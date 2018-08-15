class CustomController < ApplicationController
  before_action :authenticate_user!

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
      @products = Product.all.order("created_at DESC")
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
end
