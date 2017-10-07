class MainController < ApplicationController

  def index

    #категории для главной страницы
    @categories = Category.where(view_main: true)
    #продукты для главной
    @products = Product.where(view_main: true)


  end


end