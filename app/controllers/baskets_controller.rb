class BasketsController < ApplicationController

  def index

    @basket = Basket.new

    #если пользователь авторизован
    if !current_user.nil?

      #смотрим все заказы текущего пользователя
      @orders = Order.where(user_id: current_user.id)

      #массив для товаров в заказе
      @mass_products_in_basket = []

      #массив для товаров в заказе развернутый
      @mass_products_in_basket_full = []

      #массив для данных о товарах в заказе
      @mass_products = []

      #смотрим товары в заказах
      @orders.each do |order|
        @product_in_basket = Basket.where(order_id: "#{order.id}")
        @mass_products_in_basket.push(@product_in_basket)
      end

      #смотрим товары
      @mass_products_in_basket.each do |products|
        products.each do |product|
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

      #смотрим все заказы текущего пользователя
      @orders = Unknown_Order.where(unknown_remember_token: @unknown_remember_token)

      #массив для товаров в заказе
      @mass_products_in_basket = []

      #массив для товаров в заказе развернутый
      @mass_products_in_basket_full = []

      #массив для данных о товарах в заказе
      @mass_products = []

      #смотрим товары в заказах
      @orders.each do |order|
        @product_in_basket = Basket.where(order_id: "#{order.id}")
        @mass_products_in_basket.push(@product_in_basket)
      end

      #смотрим названия товаров
      @mass_products_in_basket.each do |products|
        products.each do |product|
          @mass_products_in_basket_full.push(product)
          @product = Product.find_by(id: "#{product.product_id}")
          @mass_products.push(@product)
        end
      end

    end

  end


  def add_basket

    #добавляем товар в корзину через аякс
    if params[:add_basket]

      #если пользователь авторизован
      if !current_user.nil?

        #смотрим есть ли у данного пользователя заказ в статусе оформляется
        @order_process = Order.find_by(user_id: params[:order][:user_id], order_status_id: params[:order][:order_status_id])

        #если есть, то
        if @order_process

          #ищем по трем параметрам, есть ли такой товар уже в корзине данного пользователя в этом заказе
          @basket_unik = Basket.find_by(order_id: @order_process.id, product_id: params[:order][:product_id], status_user_id: params[:order][:status_user_id])

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

          #смотрим есть ли у данного пользователя заказ в статусе оформляется
          @order_process = Unknown_Order.find_by(unknown_remember_token: @unknown_remember_token, order_status_id: params[:order][:order_status_id])

          puts @order_process

          #если есть, то
          if @order_process

            #ищем по трем параметрам, есть ли такой товар уже в корзине данного пользователя в этом заказе
            @basket_unik = Basket.find_by(order_id: @order_process.id, product_id: params[:order][:product_id], status_user_id: params[:order][:status_user_id])

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
          end

        #если он впервые
        else

          #выдаем ему токен - просто для идентификации, что он уже что то делал с корзиной
          @unknown_remember_token = SecureRandom.urlsafe_base64
          cookies.permanent[:unknown_remember_token] = @unknown_remember_token

          #создаем новый заказ у неавторизованного пользователя
          @new_unknown_order = Unknown_Order.new(unknown_order_params)

          if @new_unknown_order.save

            #если заказ создан, то закидываем в него токен пользователя
            @new_unknown_order.update_attribute(:unknown_remember_token, Digest::SHA1.hexdigest(@unknown_remember_token))

            #смотрим id последнего заказа
            @id_last_unknown_order = Unknown_Order.last.id

            #добавляем товар в корзину
            @new_add_basket = Basket.new(basket_params)

            respond_to do |format|

              if @new_add_basket.save

                #если товар добавлен в корзину, то закидываем в него id заказа
                @new_add_basket.update_attributes(order_id: @id_last_unknown_order)

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

      end

    end
  end


  def new


  end


  def create

    #если удаляем товар из корзины
    if params[:delete_product_from_basket]

      #ищем поле по трем параметрам
      @delete_product_from_basket = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id], status_user_id: params[:basket][:status_user_id])

      #если нашли, то удаляем
      if @delete_product_from_basket

        respond_to do |format|

          if @delete_product_from_basket.destroy

            ###### смотрим сколько товаров осталось у пользователя и передаем информацию о них в аякс ######

            #если пользователь авторизован
            if !current_user.nil?

              @status_user_id = 1

              #смотрим все заказы текущего пользователя
              @orders = Order.where(user_id: current_user.id)

              #массив для товаров в заказе
              @mass_products_in_basket = []

              #массив для товаров в заказе развернутый
              @mass_products_in_basket_full = []

              #массив для данных о товарах в заказе
              @mass_products = []

              #смотрим товары в заказах
              @orders.each do |order|
                @product_in_basket = Basket.where(order_id: "#{order.id}")
                @mass_products_in_basket.push(@product_in_basket)
              end

              #смотрим товары
              @mass_products_in_basket.each do |products|
                products.each do |product|
                  @mass_products_in_basket_full.push(product)
                  @product = Product.find_by(id: "#{product.product_id}")
                  @mass_products.push(@product)
                end
              end

            #если не авторизован
            else

              @status_user_id = 2

              #текущий пользователь по кукам
              @unknown_remember_token = cookies[:unknown_remember_token].to_s

              #кодируем токен для поиска по базе
              @unknown_remember_token = Digest::SHA1.hexdigest(@unknown_remember_token)

              #смотрим все заказы текущего пользователя
              @orders = Unknown_Order.where(unknown_remember_token: @unknown_remember_token)

              #массив для товаров в заказе
              @mass_products_in_basket = []

              #массив для товаров в заказе развернутый
              @mass_products_in_basket_full = []

              #массив для данных о товарах в заказе
              @mass_products = []

              #смотрим товары в заказах
              @orders.each do |order|
                @product_in_basket = Basket.where(order_id: "#{order.id}")
                @mass_products_in_basket.push(@product_in_basket)
              end

              #смотрим названия товаров
              @mass_products_in_basket.each do |products|
                products.each do |product|
                  @mass_products_in_basket_full.push(product)
                  @product = Product.find_by(id: "#{product.product_id}")
                  @mass_products.push(@product)
                end
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

      #ищем поле по трем параметрам
      @add_one_product = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id], status_user_id: params[:basket][:status_user_id])

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

      #ищем поле по трем параметрам
      @delete_one_product = Basket.find_by(product_id: params[:basket][:product_id], order_id: params[:basket][:order_id], status_user_id: params[:basket][:status_user_id])

      #если нашли, то обновляем кол-во на единицу
      if @delete_one_product

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
            format.json { render json: {message: 'Уменьшен на единицу', id: @id_product_in_basket, number: @number, numbers_in_basket: numbers_in_basket, price: @price_product} }
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


  end



  private

  def basket_params
    params.require(:order).permit(:product_id, :number, :status_user_id)
  end

  def order_params
    params.require(:order).permit(:user_id, :order_status_id)
  end

  def unknown_order_params
    params.require(:order).permit(:order_status_id)
  end


end