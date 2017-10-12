class BasketsController < ApplicationController

  def index

    @basket = Basket.new

    #если пользователь авторизован
    if !current_user.nil?

      #смотрим заказ текущего пользователя в статусе оформляется
      @order = Order.find_by(user_id: current_user.id, order_status_id: 1)

      #если нашли заказ
      if @order

        #массив для товаров в заказе развернутый
        @mass_products_in_basket_full = []

        #массив для данных о товарах в заказе
        @mass_products = []

        @mass_products_in_basket = Basket.where(order_id: @order.id)

        #смотрим названия товаров
        @mass_products_in_basket.each do |product|
          @mass_products_in_basket_full.push(product)
          @product = Product.find_by(id: "#{product.product_id}")
          @mass_products.push(@product)
        end

      end

    #если не авторизован
    else

      #текущий пользователь по кукам
      @unknown_remember_token = cookies[:unknown_remember_token].to_s

      #кодируем токен для поиска по базе
      @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)

      #смотрим есть ли такой пользователь
      @unknown_user = Unknown_User.find_by(unknown_remember_token: @unknown_remember_token)

      if @unknown_user

        #смотрим заказ текущего пользователя в статусе оформляется
        @order = Order.find_by(user_id: @unknown_user.id, order_status_id: 1)

        #если нашли заказ
        if @order

          #массив для товаров в заказе развернутый
          @mass_products_in_basket_full = []

          #массив для данных о товарах в заказе
          @mass_products = []

          @mass_products_in_basket = Basket.where(order_id: @order.id)

          #смотрим названия товаров
          @mass_products_in_basket.each do |product|
            @mass_products_in_basket_full.push(product)
            @product = Product.find_by(id: "#{product.product_id}")
            @mass_products.push(@product)
          end

        end

      end

    end

  end

  def show

  end


  def add_basket

    #добавляем товар в корзину через аякс
    if params[:add_basket]

      #если пользователь авторизован
      if !current_user.nil?

        #смотрим есть ли у данного пользователя заказ в статусе оформляется
        @order_process = Order.find_by(user_id: params[:order][:user_id], order_status_id: params[:order][:order_status_id], status_user_id: params[:order][:status_user_id])

        #если есть, то
        if @order_process

          #ищем по двум параметрам, есть ли такой товар уже в корзине данного пользователя в этом заказе
          @basket_unik = Basket.find_by(order_id: @order_process.id, product_id: params[:order][:product_id])

          #если есть, то увеличиваем число в корзине у этого товара на единицу
          if @basket_unik

            respond_to do |format|

              #смотрим сколько конкретного товара в корзине и прибавляем один
              @number = @basket_unik.number + 1

              if @basket_unik.update_attributes(number: @number)

                #смотрим сколько товаров в корзине всего
                @all_number = numbers_in_basket

                format.json { render json: {basket_unik: @basket_unik, number: @all_number} }
              else
                format.json { render json: {basket: 'Что то пошло не так'}, status: 423 }
              end
            end

          #если такого товара не нашлось, то просто добавляем его в корзину
          else

            @new_add_basket = Basket.new(basket_params)
            respond_to do |format|
              if @new_add_basket.save

                #если товар добавлен в корзину, то закидываем в него id заказа
                @new_add_basket.update_attributes(order_id: @order_process.id)

                #смотрим сколько товаров в корзине
                @number = numbers_in_basket

                format.json { render json: {new_add_basket: @new_add_basket, number: @number} }
              else
                format.json { render json: {basket: 'Товар не добавился в корзину'}, status: 423 }
              end
            end

          end

        #если нет, то
        else

          #создаем новый заказ у пользователя
          @new_order = Order.new(order_params)

          if @new_order.save

            #смотрим id последнего заказа
            @id_last_order = Order.last.id

            #добавляем товар в корзину
            @new_add_basket = Basket.new(basket_params)

            respond_to do |format|

              if @new_add_basket.save

                #если товар добавлен в корзину, то закидываем в него id заказа
                @new_add_basket.update_attributes(order_id: @id_last_order)

                #смотрим сколько товаров в корзине
                @number = numbers_in_basket

                format.json { render json: {new_add_basket: @new_add_basket, number: @number} }
              else
                format.json { render json: {basket: 'Товар не добавился в корзину'}, status: 423 }
              end
            end

          else
            #как то обработать ошибку
          end

        end

      #если пользователь не авторизован
      else

        @unknown_remember_token = cookies[:unknown_remember_token].to_s

        #если этот пользователь уже был и токен есть у него в куках
        if !@unknown_remember_token.blank?

          #кодируем токен для поиска по базе
          @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)

          #смотрим есть ли такой пользователь
          @user_process = Unknown_User.find_by(unknown_remember_token: @unknown_remember_token)

          if @user_process

            #смотрим есть ли у данного пользователя заказ в статусе оформляется
            @order_process = Order.find_by(user_id: @user_process.id, order_status_id: params[:order][:order_status_id], status_user_id: params[:order][:status_user_id])

            #если есть, то
            if @order_process

              #ищем по двум параметрам, есть ли такой товар уже в корзине данного пользователя в этом заказе
              @basket_unik = Basket.find_by(order_id: @order_process.id, product_id: params[:order][:product_id])

              #если есть, то увеличиваем число в корзине у этого товара на единицу
              if @basket_unik

                respond_to do |format|

                  #смотрим сколько конкретного товара в корзине и прибавляем один
                  @number = @basket_unik.number + 1

                  if @basket_unik.update_attributes(number: @number)

                    #смотрим сколько товаров в корзине всего
                    @all_number = numbers_in_basket

                    format.json { render json: {basket_unik: @basket_unik, number: @all_number} }
                  else
                    format.json { render json: {basket: 'Что то пошло не так'}, status: 423 }
                  end
                end

              #если такого товара не нашлось, то просто добавляем его в корзину
              else

                @new_add_basket = Basket.new(basket_params)

                respond_to do |format|

                  if @new_add_basket.save

                    #если товар добавлен в корзину, то закидываем в него id заказа
                    @new_add_basket.update_attributes(order_id: @order_process.id)

                    #смотрим сколько товаров в корзине
                    @number = numbers_in_basket

                    format.json { render json: {new_add_basket: @new_add_basket, number: @number} }
                  else
                    format.json { render json: {basket: 'Товар не добавился в корзину'}, status: 423 }
                  end
                end

              end

            #если токен есть, а заказа в статусе оформляется нет (т.е. например пользователь отправил заказ и у него только закрытые заказы есть)
            else

              #создаем новый заказ
              @new_order = Order.new(user_id: @user_process.id, order_status_id: 1, status_user_id: 2)

              if @new_order.save

                #добавляем товар в корзину
                @new_add_basket = Basket.new(basket_params)

                respond_to do |format|

                  if @new_add_basket.save

                    #если товар добавлен в корзину, то закидываем в него id заказа
                    @new_add_basket.update_attributes(order_id: @new_order.id)

                    #смотрим сколько товаров в корзине
                    @number = numbers_in_basket

                    format.json { render json: {new_add_basket: @new_add_basket, number: @number} }
                  else
                    format.json { render json: {basket: 'Товар не добавился в корзину'}, status: 423 }
                  end
                end

              end

            end

          end

        #если он впервые
        else

          #выдаем ему токен - просто для идентификации, что он уже что то делал с корзиной
          @unknown_remember_token = SecureRandom.urlsafe_base64
          cookies.permanent[:unknown_remember_token] = @unknown_remember_token

          #создаем нового неавторизованного пользователя
          @new_unknown_user = Unknown_User.new(unknown_remember_token: Digest::SHA1.hexdigest(@unknown_remember_token))

          #если пользователь создан
          if @new_unknown_user.save

            #создаем новый заказ
            @new_order = Order.new(user_id: @new_unknown_user.id, order_status_id: 1, status_user_id: 2)

            if @new_order.save

              #добавляем товар в корзину
              @new_add_basket = Basket.new(basket_params)

              respond_to do |format|

                if @new_add_basket.save

                  #если товар добавлен в корзину, то закидываем в него id заказа
                  @new_add_basket.update_attributes(order_id: @new_order.id)

                  #смотрим сколько товаров в корзине
                  @number = numbers_in_basket

                  format.json { render json: {new_add_basket: @new_add_basket, number: @number} }
                else
                  format.json { render json: {basket: 'Товар не добавился в корзину'}, status: 423 }
                end
              end

            end

          else
            #как то обработать ошибку
          end

        end

      end

    end
  end


  def new


  end


  def create

    #если удаляем товар из корзины
    if params[:delete_product_from_basket]

      #ищем поле по двум параметрам
      @delete_product_from_basket = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id])

      #если нашли, то удаляем
      if @delete_product_from_basket

        respond_to do |format|

          if @delete_product_from_basket.destroy

            ###### смотрим сколько товаров осталось у пользователя и передаем информацию о них в аякс ######

            #если пользователь авторизован
            if !current_user.nil?

              @status_user_id = 1

              #смотрим заказ текущего пользователя в статусе оформляется
              @orders = Order.find_by(user_id: current_user.id, order_status_id: 1)

              #массив для товаров в заказе развернутый
              @mass_products_in_basket_full = []

              #массив для данных о товарах в заказе
              @mass_products = []

              @mass_products_in_basket = Basket.where(order_id: @order.id)

              #смотрим названия товаров
              @mass_products_in_basket.each do |product|
                @mass_products_in_basket_full.push(product)
                @product = Product.find_by(id: "#{product.product_id}")
                @mass_products.push(@product)
              end

            #если не авторизован
            else

              @status_user_id = 2

              #текущий пользователь по кукам
              @unknown_remember_token = cookies[:unknown_remember_token].to_s

              #кодируем токен для поиска по базе
              @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)

              #смотрим текущего пользователя
              @unknown_user = Unknown_User.find_by(unknown_remember_token: @unknown_remember_token)

              #смотрим заказ текущего пользователя в статусе оформляется
              @order = Order.find_by(user_id: @unknown_user.id, order_status_id: 1)

              #массив для товаров в заказе развернутый
              @mass_products_in_basket_full = []

              #массив для данных о товарах в заказе
              @mass_products = []

              @mass_products_in_basket = Basket.where(order_id: @order.id)

              #смотрим названия товаров
              @mass_products_in_basket.each do |product|
                @mass_products_in_basket_full.push(product)
                @product = Product.find_by(id: "#{product.product_id}")
                @mass_products.push(@product)
              end

            end

            # передаем информацию в аякс
            format.json { render json: {message: 'Товар удален', mass_products: @mass_products, mass_products_in_basket_full: @mass_products_in_basket_full, status_user_id: @status_user_id} }
          else
            format.json { render json: {message: 'Товар не удалился'}, status: 423 }
          end

        end

      #если не нашли, то ошибка
      else
        flash[:error] = 'Что то пошло не так!'
        redirect_to baskets_path
      end

    end

    #если увеличиваем кол-во товара на единицу
    if params[:add_one_product]

      #ищем поле по двум параметрам
      @add_one_product = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id])

      #если нашли, то обновляем кол-во на единицу
      if @add_one_product

        #увеличиваем на единицу
        @number = @add_one_product.number + 1

        respond_to do |format|

          if @add_one_product.update_attributes(number: @number)

            #id обновляемого продукта
            @id_product_in_basket = params[:basket][:product_id]

            #цена обновляемого продукта
            @price_product = Product.find_by(id: @id_product_in_basket).price

            # передаем информацию в аякс
            format.json { render json: {message: 'Увеличен на единицу', id: @id_product_in_basket, number: @number, numbers_in_basket: numbers_in_basket, price: @price_product} }
          else
            format.json { render json: {message: 'Товар не добавился на единицу'}, status: 423 }
          end

        end

      #если не нашли, то ошибка
      else
        flash[:error] = 'Что то пошло не так!'
        redirect_to baskets_path
      end

    end


    #если уменьшаем кол-во товара на единицу
    if params[:delete_one_product]

      #ищем поле по двум параметрам
      @delete_one_product = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id])

      #если нашли, то обновляем кол-во на единицу
      if @delete_one_product

        #сколько товара было до уменьшения
        @numbers_product_before = @delete_one_product.number

        #если число данного товара равно единице, то не уменьшаем, чтобы число не стало нулем - иначе пусть пользователь удаляет товар вообще из корзины
        if @delete_one_product.number == 1
          @number = 1
        #иначе уменьшаем на единицу
        else
          @number = @delete_one_product.number - 1
        end

        respond_to do |format|

          if @delete_one_product.update_attributes(number: @number)

            #id обновляемого продукта
            @id_product_in_basket = params[:basket][:product_id]

            #цена обновляемого продукта
            @price_product = Product.find_by(id: @id_product_in_basket).price

            # передаем информацию в аякс
            format.json { render json: {message: 'Уменьшен на единицу', id: @id_product_in_basket, number: @number, numbers_product_before: @numbers_product_before, numbers_in_basket: numbers_in_basket, price: @price_product} }
          else
            format.json { render json: {message: 'Товар не уменьшился на единицу'}, status: 423 }
          end

        end

      #если не нашли, то ошибка
      else
        flash[:error] = 'Что то пошло не так!'
        redirect_to baskets_path
      end

    end

    #если отправляем заказ на оформление
    if params[:order]

      #если пользователь авторизован
      if !current_user.nil?

        #смотрим заказ текущего пользователя в статусе оформляется
        @order = Order.find_by(user_id: current_user.id, order_status_id: 1)

        #для отправки письма
        @user = current_user

      #если не авторизован
      else

        #текущий пользователь по кукам
        @unknown_remember_token = cookies[:unknown_remember_token].to_s

        #кодируем токен для поиска по базе
        @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)

        #смотрим текущего пользователя
        @unknown_user = Unknown_User.find_by(unknown_remember_token: @unknown_remember_token)

        #для отправки письма
        @user = @unknown_user

        #смотрим заказ текущего пользователя в статусе оформляется
        @order = Order.find_by(user_id: @unknown_user.id, order_status_id: 1)

        #обновляем данные о неизвестном пользователе
        @unknown_user.update_attributes(unknown_user_name: params[:unknown_user_name], email: params[:email], telephone: params[:telephone])

      end

      #если нашли заказ
      if @order

        #обновляем его статус на "отправлен"
        @order.update_attributes(order_status_id: 2)

      end

      #массив для товаров в заказе развернутый
      @mass_products_in_basket_full = []

      #массив для данных о товарах в заказе
      @mass_products = []

      @mass_products_in_basket = Basket.where(order_id: @order.id)

      #смотрим названия товаров
      @mass_products_in_basket.each do |product|
        @mass_products_in_basket_full.push(product)
        @product = Product.find_by(id: "#{product.product_id}")
        @mass_products.push(@product)
      end

      #отправляем уведомление о заказе на почту админа
      if FormMailer.order_email(@order, @user, @mass_products, @mass_products_in_basket_full).deliver_now

        #если пользователь не зарегистрирован
        if @order.status_user_id == 2
          flash[:success] = "#{@user.unknown_user_name}, Ваш заказ в обработке!"
        end
        #если пользователь зарегистрирован
        if @order.status_user_id == 1
          flash[:success] = "#{@user.user_name}, Ваш заказ в обработке!"
        end

        redirect_to '/baskets/show'

      end

    end


  end



  private

  def basket_params
    params.require(:order).permit(:product_id, :number)
  end

  def order_params
    params.require(:order).permit(:user_id, :order_status_id, :status_user_id)
  end

end