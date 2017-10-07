class CategoriesController < ApplicationController

  #чтобы создавать, редактировать, обновлять, удалять нужно войти как админ
  before_action :signed_in_user, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all.order(:id)
  end


  def show

    ########### смотрим что пришло в запросе  ###########

    #текущая категория
    @category = Category.find_by_friendly_url(params[:id])
    #текущий продукт
    @product = Product.find_by_friendly_url(params[:id])

    ########### смотрим что пришло в запросе  ###########

    #если пришла категория
    if @category

      #смотрим есть ли у нее подкатегории
      @subcategory = @category.children

      #и продукты
      @products = Product.where(category_id: @category.id)

    #если пришел продукт
    elsif @product

      #категория, который принадлежит продукт
      @parent_category_product = Category.find_by_id(@product.category_id)

      #если данная категория не родительская
      if @parent_category_product.parent_id != 0
        #то запускаем цикл и складываем туда родительские категории пока не дойдем до самой верхней
        @main_cat = [@parent_category_product]
        i = 0
        while !@main_cat[i].parent.nil?
          @main_cat[@main_cat.size] = @main_cat[i].parent
          i+=1
        end
        redirect_to '/'+@main_cat.last.friendly_url+'/'+@parent_category_product.friendly_url+'/'+params[:id], status: 301

      #если данная категория родительская
      else
        redirect_to '/'+@parent_category_product.friendly_url+'/'+params[:id], status: 301

      end

    else
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end


  end


  def edit
    #текущая категория
    @category = Category.find_by_friendly_url(params[:category_id])

    @categories = Category.all.order(:id)
  end

  def update
    #текущая категория
    @category = Category.find_by_id(params[:id])

    if @category.update_attributes(category_params)
      flash[:success] = 'Категория обновлена!'
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def new
    @category = Category.new
    @categories = Category.all.order(:id)
  end


  def create

    #создаем категорию
    if params[:category]

      @category = Category.find_by_friendly_url(params[:category][:friendly_url])
      @product = Product.find_by_friendly_url(params[:category][:friendly_url])

      #если категория с таким названием есть
      if @category || @product
        #сохраняем заполненные данные
        @category_name = params[:category][:category_name]
        @category_content = params[:category][:category_content]

        @category = Category.new
        @categories = Category.all.order(:id)
        flash[:error] = 'Такое название уже есть в базе!'
        render 'categories/new'
        #если нет, то создаем категорию
      else
        @category = Category.new(category_params)
        if @category.save
          flash[:success] = 'Категория добавлена!'
          redirect_to categories_path
        else
          @categories = Category.all.order(:id)
          render 'categories/new'
        end
      end

    end

  end

  def destroy
    #текущая категория
    @category = Category.find_by_id(params[:id])

    if @category.destroy
      flash[:notice] = "Категория '#{@category.category_name}' удалена!"
      redirect_to categories_path
    else
      redirect_to @category
    end
  end


  private

  def category_params
    params.require(:category).permit(:category_name, :parent_id, :category_id, :friendly_url, :view_main, :category_content, :image)
  end

  def signed_in_user
    #если текущий пользователь пустой
    if current_user.nil?
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    else
      #если пользователь не админ
      if !admin?
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      end
    end
  end


end