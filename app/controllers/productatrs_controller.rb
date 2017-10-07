class ProductatrsController < ApplicationController

  #чтобы что то делать нужно войти
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :create, :new, :destroy]

  def index
    @all_attrs = Productatr.all.order(:id)
    @attr = Productatr.new
  end

  def show

  end

  def edit
    #текущий аттрибут
    @attr = Productatr.find_by_id(params[:id])
  end

  def update

    #текущий аттрибут
    @attr = Productatr.find_by_id(params[:id])

    if @attr.update_attributes(new_attr_params)
      flash[:success] = 'Название атрибута обновлено!'
      redirect_to edit_productatr_path(@attr)
    else
      render 'edit'
    end

  end

  def new
    @new_attr = Productatr.new
  end

  def create

    @new_attr = Productatr.find_by_attribute_name(params[:productatr][:attribute_name])
    #если в базе уже есть аттрибут с таким названием
    if @new_attr
      @new_attr = Productatr.new
      flash[:error] = 'Такое название аттрибута уже есть!'
      render 'productatrs/new'
    #если нет, то создаем
    else
      @new_attr = Productatr.new(new_attr_params)
      if @new_attr.save
        flash[:success] = 'Новый аттрибут добавлен!'
        redirect_to productatrs_path
      else
        @attribute_rus_name = params[:productatr][:attribute_rus_name]
        render 'productatrs/new'
      end
    end


  end

  def destroy
    #текущий аттрибут
    @attr = Productatr.find_by_id(params[:id])

    if @attr.delete
      flash[:notice] = 'Аттрибут удален!'
      redirect_to productatrs_path
    else
      redirect_to @attr
    end
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

  private

  def new_attr_params
    params.require(:productatr).permit(:attribute_rus_name, :attribute_name)
  end


end