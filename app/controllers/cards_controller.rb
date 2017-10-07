class CardsController < ApplicationController

  #чтобы что то делать нужно войти
  before_action :signed_in_user, only: [:index, :new, :edit, :update, :create, :destroy]

  #перед действиями узнаем все о текущей карточке
  before_action :about_card, only: [:edit, :update, :destroy, :create_input_card]


  def index
    @cards = Card.all.order(:id)
  end

  def new
    @new_card = Card.new
  end

  def create

    @new_card = Card.find_by_card_name(params[:card][:card_name])
    #если в базе уже есть карточка с таким названием
    if @new_card
      @new_card = Card.new
      flash[:error] = 'Такое название у карточки уже есть!'
      render 'cards/new'
      #если нет, то создаем
    else
      @new_card = Card.new(new_card_params)
      if @new_card.save
        flash[:success] = 'Новая карточка товара создана!'
        redirect_to cards_path
      else
        @card_name = params[:card][:card_name]
        render 'cards/new'
      end
    end


  end

  def show

  end

  def edit

    @card_attrs = Card_With_Attribute.new

    @attrs = Productatr.all.order(:id)

  end

  def update

    if @card.update_attributes(new_card_params)
      flash[:success] = 'Название карточки обновлено!'
      redirect_to edit_card_path(@card)
    else
      render 'edit'
    end

  end

  def destroy

    if @card.delete

      #находим все аттрибуты удаленной карточки
      @card_attrs = Card_With_Attribute.where(card_id: @card.id)
      #удаляем их
      @card_attrs.each do |card|
        card.delete
      end

      flash[:notice] = 'Карточка удалена!'
      redirect_to cards_path
    else
      redirect_to edit_card_path(@card)
    end
  end

  def create_input_card

    #если добавляем новое поле
    if params[:create_input_card]
      #ищем поле по двум параметрам
      @new_input_card = Card_With_Attribute.find_by(card_id: params[:card_with_attribute][:card_id], product_atrs_id: params[:card_with_attribute][:product_atrs_id])

      #если нашли
      if @new_input_card
        flash[:success] = 'Уже есть такое поле у карточки!'
        redirect_to edit_card_path(@card)
      #если не нашли, то добавляем
      else
        @new_input_card = Card_With_Attribute.new(input_card_params)
        if @new_input_card.save
          flash[:success] = 'Добавлено новое поле в карточку!'
          redirect_to edit_card_path(@card)
        else
          render 'show'
        end
      end
    end

    #если удаляем старое поле
    if params[:delete_input_card]
      #ищем поле по двум параметрам
      @delete_input_card = Card_With_Attribute.find_by(card_id: params[:card_with_attribute][:card_id], product_atrs_id: params[:card_with_attribute][:product_atrs_id])
      if @delete_input_card.delete
        flash[:success] = 'Поле удалено!'
        redirect_to edit_card_path(@card)
      else
        render 'show'
      end
    end

  end




  #узнаем все о текущей карточке
  def about_card
    #текущая карточка товара
    @card = Card.find_by_id(params[:id])

    #значения доп.характеристик карточки
    @attr = Card_With_Attribute.where(card_id: @card.id)

    #id доп характеристик карточки
    @attr_ids = []
    @attr.each do |at|
      @attr_ids.push(at.product_atrs_id)
    end

    #вынимаем сами доп.характеристики карточки по их id
    @attr_obj = []
    @attr_ids.each do |id|
      @atr = Productatr.where(id: id)
      @attr_obj.push(@atr)
    end

    #вынимаем названия доп.характеристик карточки
    @attr_names = []
    @attr_obj.each do |obj|
      obj.each do |name|
        @attr_names.push(name)
      end
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

  def input_card_params
    params.require(:card_with_attribute).permit(:card_id, :product_atrs_id)
  end

  def new_card_params
    params.require(:card).permit(:card_name)
  end

end