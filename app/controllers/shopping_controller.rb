class ShoppingController < ApplicationController
  before_action :rating_avr

  def index
    @products = Product.all.order('created_at DESC')
  end

  def category
    @p = params[:category]

    case @p
    when 'price'
      price
    when 'created'
      @products = Product.all.order('created_at DESC')
    else 'review'
      review(Product.all)
    end
  end

  def price
    @products = Product.all
    @productArray = Array.new(@products.count){Array.new(2)}
    index = 0

    @products.each do |product|
      @productArray[index][1] = product.id
      @productArray[index][0] = product.price.to_i
      index += 1
    end

    @productArray = @productArray.sort.reverse
    @products = []
    for i in 0..(@productArray.length-1)
      @products << Product.find_by_id(@productArray[i][1])
    end
  end

  def review(products)
    @productArray = Array.new(products.count){Array.new(2)}
    index = 0

    products.each do |product|
      @productArray[index][1] = product.id
      @productArray[index][0] = product.score
      index +=1
    end

    # @products 재배열
  	@productArray = @productArray.sort.reverse
    @products = []
    for i in 0..(@productArray.length-1)
      product = Product.find_by_id(@productArray[i][1])
      @products << product
    end
  end

  def rating_avr
    @products = Product.all
    @products.each do |product|
      # 제품의 리뷰 배열(reviews)에 저장
      reviews = product.reviews
      rate_sum = 0

      # 리뷰 총합 구하기
      reviews.each do |review|
        if review.rating == nil
          review.rating = 0
        else
          rate_sum += review.rating
        end
      end

      # 리뷰 평점 계산하기
      if rate_sum != 0
        @rate_avr = rate_sum.to_f / product.reviews.count
      elsif
        @rate_avr = 0
      end

      product.score = @rate_avr.to_f.round(1)
      product.save
    end
  end
end
