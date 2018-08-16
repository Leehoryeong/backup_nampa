class RankingController < ApplicationController
  def index
      @products = Product.all.order("created_at DESC")
      sorting(@products)
  end

  def category
    @p = params[:category]
    @products = Product.where(:category => @p)
    sorting(@products)
  end

#별점을 기준으로 소팅
  def sorting(products)
    @porducts = products
    @productArray = Array.new(@products.count){Array.new(2)}
    arrayIndex = 0

    @products.each do |product|
      @productArray[arrayIndex][1] = product.id

      reviews = product.reviews
          rate_sum = 0
          reviews.each do |review|
            if review.rating == nil
              review.rating = 0
            end
            rate_sum += review.rating
          end

          if rate_sum != 0
            rate_avr = rate_sum.to_f / product.reviews.count
          elsif
            rate_avr = 0
          end
      @productArray[arrayIndex][0] = rate_avr
      arrayIndex +=1
    end
    
    # @products 재배열
  	@productArray = @productArray.sort.reverse
    @products = []
    for i in 0..(@productArray.length-1)
      @products << Product.find(@productArray[i][1])
    end
  end

end
