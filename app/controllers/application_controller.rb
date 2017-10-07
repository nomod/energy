class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :redirect_category

  include SessionsHelper
  include BasketsHelper

  private

  # редирект с url вида "/подкатегория" на "/категория/подкатегория"
  def redirect_category

    # если пришел параметр вложенной категории, а главной нет
    if params[:category_id].nil? && params[:id]
      @category = Category.find_by_friendly_url(params[:id])
      # если такая категория есть
      if @category
        #если данная категория не родительская
        if @category.parent_id != 0
          #то запускаем цикл и складываем туда родительские категории пока не дойдем до самой верхней
          @main_cat = [@category]
          i = 0
          while !@main_cat[i].parent.nil?
            @main_cat[@main_cat.size] = @main_cat[i].parent
            i+=1
          end
          redirect_to '/'+@main_cat.last.friendly_url+'/'+params[:id], status: 301
        end
      end

    # если никаких параметров не пришло, то ничего не делаем
    else

    end
  end



  # def undefined_user
  #
  #   remember_token = cookies[:remember_token]
  #
  #   if remember_token
  #
  #
  #   else
  #
  #     remember_token = SecureRandom.urlsafe_base64
  #     cookies.permanent[:remember_token] = remember_token
  #
  #     @user = User.new(remember_token: Digest::SHA1.hexdigest(remember_token))
  #
  #     @user.create
  #
  #
  #   end
  #
  # end


end