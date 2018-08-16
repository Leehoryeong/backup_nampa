class CustomController < ApplicationController
  before_action :authenticate_user!
  before_action :rating_avr

  def info
    if current_user.userspec
      @userspec = current_user.userspec
      redirect_to '/custom'
    end
  end

  def index
    if current_user.userspec
      @products = Product.all
      sorting(@products)
    elsif
      review(@products = Product.all.order("created_at DESC"))
    end
  end

  def category
    @p = params[:category]
    @products = Product.where(:category => @p)
    if current_user.userspec
      sorting(@products)
    elsif
      @products = @products.order("created_at DESC")
    end
  end

  def rating_avr(product)
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
  end

  def sorting(products)
    @us = current_user.userspec
    @products = products
    @productArray = Array.new(@products.count){Array.new(2)}
    keys = ['skintype', 'age', 'atopy', 'pimple', 'allergy', 'bb', 'lip', 'eyebrow', 'eyeline', 'color', 'skincolor']
    arrayIndex = 0

    # 제품스펙과 유저스펙 비교
    @products.each do |product|
      @productArray[arrayIndex][1] = product.id
      @productArray[arrayIndex][0] = 0

      for i in 0..10
        if @us[keys[i]]
          if @us[keys[i]] == product[keys[i]]
            @productArray[arrayIndex][0] += 1
          end
        end
      end
      arrayIndex += 1
    end

    # @products 재배열
    @productArray = @productArray.sort.reverse
    @products = []
    for i in 0..(@productArray.length-1)
      @products << Product.find(@productArray[i][1])
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
