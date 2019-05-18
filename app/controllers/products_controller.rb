class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @sort = Review.all.order(created_at: :desc).where(product_id: params[:id])
    @average = Review.all.where(product_id: params[:id]).average(:rating)
  end

end

