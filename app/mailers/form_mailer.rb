class FormMailer < ApplicationMailer
  default from: 'info@energycity.ru'

  def service_email(user)
    @user = user
    #если нужно на несколько адресов
    #mail(to: 'nomod@list.ru', subject: 'Тема письма', :bcc => ["m.ryadn@gmail.com", "ryadn@yandex.ru"])
    mail(to: "#{@user.email}", subject: 'Регистрация пользователя')
  end

  def confirmation_email(user)
    @user = user
    mail(to: 'm.ryadn@gmail.com', subject: 'Подтверждение регистрации')
  end

  def reset_email(user)
    @user = user
    mail(to: "#{@user.email}", subject: 'Сброс пароля')
  end

  def after_update_password(user)
    @user = user
    mail(to: "#{@user.email}", subject: 'Пароль обновлен')
  end

  def order_email(order, user, mass_products, mass_products_in_basket_full)
    @order = order
    @user = user
    @mass_products = mass_products
    @mass_products_in_basket_full = mass_products_in_basket_full
    mail(to: 'nomod@list.ru', subject: 'Новая заявка')
  end
end