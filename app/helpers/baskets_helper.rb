module BasketsHelper

  #смотрим сколько у текущего пользователя товаров в корзине
  def numbers_in_basket

    if !current_user.nil?

      @order = Order.find_by(user_id: current_user.id, order_status_id: 1)

      #если у пользователя есть заказ в статусе оформляется
      if !@order.blank?

        #включаем счетчик
        @number = 0

        #ищем все товары в заказе
        @basket = Basket.where(order_id: @order.id)

        #перебираем все товары в заказе и суммируем кол-во
        @basket.each do |num|
          @number = @number + num.number
        end

        @number

        #если у пользователя нет товаров в корзине
      else
        @basket = 'нет'
      end

    else

      unknown_remember_token = cookies[:unknown_remember_token].to_s

      #если есть токен неизвестного пользователя в куках
      if unknown_remember_token

        #поиск по токену в таблице заказов данного пользователя
        #выдергиваем из куки токен, шифруем его и ищем такой же в базе
        #to_s - нужен, если куки пустые

        unknown_remember_token = Digest::SHA1.hexdigest(cookies[:unknown_remember_token].to_s)

        @unknown_order = Unknown_Order.find_by(unknown_remember_token: unknown_remember_token)

        #если нашли заказ
        if @unknown_order

          #включаем счетчик
          @number = 0

          #ищем все товары в заказе
          @basket = Basket.where(order_id: @unknown_order.id)

          #перебираем все товары в заказе и суммируем кол-во
          @basket.each do |num|
            @number = @number + num.number
          end

          #если у данного заказа есть товары(возможен вариант когда пользователь удалил все товары из заказа, а заказ остался)
          if @number != 0
            @number
          #иначе
          else
            @basket = 'нет'
          end

        #если нет заказа
        else
          @basket = 'нет'
        end

      #если пусто в куках
      else
        @basket = 'нет'
      end

    end

  end


end