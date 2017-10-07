class SearchController < ApplicationController

  def index

    #категории
    @categories = Category.where("category_name LIKE '%#{params[:search]}%'")

    #продукты
    @products = Product.where("product_title LIKE '%#{params[:search]}%'")


  end


end