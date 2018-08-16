class ShoppingController < ApplicationController
  def index
      @products = Product.all.order("created_at DESC")
  end

  def category
    @p = params[:category]
    @products = Product.where(:category => @p)
    @products = @products.order("created_at DESC")
  end
end

