class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    #если пользователь с такой почтой существует и у него в базе есть введенный пароль
    if @user && @user.authenticate(params[:session][:password])
      #если у пользователя в базе email_confirmed = true, т.е. подтвержден
      if @user.email_confirmed
        #если пользователя проверил и утвердил админ
        if @user.status

          sign_in(@user)


          ################# действия при авторизации если пользователь что то делал будучи не авторизован #################

          #смотрим совершал ли данный пользователь манипуляции с корзиной будучи неавторизованным
          @unknown_remember_token = cookies[:unknown_remember_token].to_s

          #если есть куки неавторизованного пользователя
          if @unknown_remember_token

            #кодируем токен для поиска по базе
            @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)
            #смотрим есть ли заказ в статусе оформляется
            @unknown_order = Unknown_Order.find_by(unknown_remember_token: @unknown_remember_token, order_status_id: 1)
            #id заказа
            @unknown_order.id
            #смотрим какие товары лежат в корзине по этому заказу
            @products_in_basket = Basket.where(order_id: @unknown_order.id, status_user_id: 2)

            #удаляем токен неавторизованного пользователя из куки
            cookies.delete(:unknown_remember_token)
            #удаляем его заказ
            @unknown_order.destroy

            #смотрим есть ли у данного пользователя заказ в статусе оформляется когда он был авторизован
            @order_known = Order.find_by(user_id: current_user.id, order_status_id: 1)

            #если есть заказ
            if @order_known

              #смотрим какие товары лежат в корзине по этому заказу
              @known_products_in_basket = Basket.where(order_id: @order_known.id, status_user_id: 1)
              #удаляяем их
              @known_products_in_basket.each do |product|
                product.destroy
              end

              #удаляем старый заказ
              @order_known.delete

              #создаем новый заказ
              @new_order = Order.new(user_id: current_user.id, order_status_id: 1)

              if @new_order.save

                #смотрим id созданного заказа
                @id_last_known_order = Order.last.id

                #перебираем найденные товары и обновляем у них статус пользователя и id заказа
                @products_in_basket.each do |product|
                  product.update_attributes(status_user_id: 1, order_id: @id_last_known_order)
                end

              else
                flash[:error] = 'Что то пошло не так!'
                redirect_to baskets_path
              end

            #если нет заказа
            else

              #создаем новый заказ
              @new_order = Order.new(user_id: current_user.id, order_status_id: 1)

              if @new_order.save

                #смотрим id созданного заказа
                @id_last_known_order = Order.last.id

                #перебираем найденные товары и обновляем у них статус пользователя и id заказа
                @products_in_basket.each do |product|
                  product.update_attributes(status_user_id: 1, order_id: @id_last_known_order)
                end

              else
                flash[:error] = 'Что то пошло не так!'
                redirect_to baskets_path
              end

            end

          end

          ################# действия при авторизации если пользователь что то делал будучи не авторизован #################


          redirect_to root_url
        else
          flash.now[:error] = 'Аккаунт на модерации!'
          render 'new'
        end
      else
        flash.now[:error] = 'Вы не прошли подтверждение по почте!'
        render 'new'
      end
    else
      flash.now[:error] = 'Неправильная пара логин/пароль'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private


end