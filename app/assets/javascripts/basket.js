$(document).ready(function() {

    //обрабатываем json ответ ajax формы добавления товара в корзину
    $("body").on("ajax:success", ".new_order", function (xhr, data) {
        //находим элемент
        var box = $(".basket");
        //обновляем кол-во
        box.html('Товаров в корзине ' + data.number);
    }).on("ajax:error", function (xhr, data) {
        //как то можно обработать ошибку
    });




    /////////// удаляем товар из корзины, обновляем кол-во товара ///////////

    //текущий урл
    var url = window.location.href;
    var arr = url.split('/');
    var last_url = arr[arr.length-1];

    //если текущий урл это baskets
    if(last_url == "baskets"){

        //обрабатываем json ответ ajax формы удаления товара из корзины, увеличение и уменьшения товара на единицу в корзине
        $("body").on("ajax:success", ".new_basket", function (xhr, data) {


            ////////////////////////// общие элементы для всех //////////////////////////

            //находим элемент корзина
            var basket = $(".basket");

            //находим итоговую сумму
            var final = $("span.num_summ");
            //вынимаем всё что внутри
            var value = $(final).text();

            //находим ячейку в таблице с кол-ом обновляемого товар в корзине
            var init = $('td#'+data.id);
            //находим форму "минус"
            var td_form = init.next().next();
            //находим в форме кнопку "минус"
            var minus = td_form.find(':input[type="submit"]');

            ////////////////////////// общие элементы для всех //////////////////////////


            //если пришло сообщение, что товар удален
            if(data.message == 'Товар удален'){

                //находим таблицу с товарами в корзине
                var box = $(".table-striped");

                /////// обновляем ///////

                //начало таблицы
                $(box).html(
                    "<thead>" +
                    "<tr>" +
                    "<th>Название продукта</th>" +
                    "<th>Цена за шт.</th>" +
                    "<th>Количество</th>" +
                    "<th></th>" +
                    "<th></th>" +
                    "<th></th>" +
                    "<th></th>" +
                    "</tr>" +
                    "</thead>"+
                    "<tbody>"
                );

                //общее количество заказов в корзине, запускаем счетчик
                var all_number = 0;
                //включаем счетчик общей суммы заказа
                var summ = 0;

                //закидываем все заказы в корзине в таблицу
                $.each(data.mass_products, function(key, value){

                    //суммируем количество всех заказов
                    all_number += data.mass_products_in_basket_full[key].number;

                    //число товаров
                    var numbers_product = data.mass_products_in_basket_full[key].number;
                    //цена товара
                    var price_product = value.price;
                    //сумма данного заказа
                    var sum_order = numbers_product * price_product;

                    //обновляем счетчик общей суммы заказа
                    summ = summ + sum_order;

                    var box = $(".table-striped tbody");
                    box.append(
                        "<tr>"+

                        "<td>"+value.product_title+"</td>"+
                        "<td>"+value.price+"</td>"+
                        "<td id='"+value.id+"'>"+data.mass_products_in_basket_full[key].number+"</td>"+

                        "<td>"+
                        "<form class='new_basket' id='new_basket' action='/baskets' accept-charset='UTF-8' data-remote='true' method='post'>" +
                        "<input name='utf8' type='hidden' value='✓'>" +
                        "<input value='"+value.id+"' type='hidden' name='basket[product_id]' id='basket_product_id'>" +
                        "<input value='"+data.mass_products_in_basket_full[key].order_id+"' type='hidden' name='basket[order_id]' id='basket_order_id'>" +
                        "<input value='"+data.status_user_id+"' type='hidden' name='basket[status_user_id]' id='basket_status_user_id'>" +
                        "<input type='submit' name='add_one_product' value='+' class='btn-primary btn-add' data-disable-with='+'>" +
                        "</form>"+
                        "</td>"+

                        "<td>"+
                        "<form class='new_basket' id='new_basket' action='/baskets' accept-charset='UTF-8' data-remote='true' method='post'>" +
                        "<input name='utf8' type='hidden' value='✓'>" +
                        "<input value='"+value.id+"' type='hidden' name='basket[product_id]' id='basket_product_id'>" +
                        "<input value='"+data.mass_products_in_basket_full[key].order_id+"' type='hidden' name='basket[order_id]' id='basket_order_id'>" +
                        "<input value='"+data.status_user_id+"' type='hidden' name='basket[status_user_id]' id='basket_status_user_id'>" +
                        "<input type='submit' name='delete_one_product' value='-' class='btn-primary btn-delete' data-disable-with='-'>" +
                        "</form>"+
                        "</td>"+

                        "<td><a href='"+value.friendly_url+"'>Просмотреть</a></td>"+

                        "<td>"+
                        "<form class='new_basket' id='new_basket' action='/baskets' accept-charset='UTF-8' data-remote='true' method='post'>" +
                        "<input name='utf8' type='hidden' value='✓'>" +
                        "<input value='"+value.id+"' type='hidden' name='basket[product_id]' id='basket_product_id'>" +
                        "<input value='"+data.mass_products_in_basket_full[key].order_id+"' type='hidden' name='basket[order_id]' id='basket_order_id'>" +
                        "<input value='"+data.status_user_id+"' type='hidden' name='basket[status_user_id]' id='basket_status_user_id'>" +
                        "<input type='submit' name='delete_product_from_basket' value='Удалить' class='btn-primary' data-disable-with='Удалить'>" +
                        "</form>"+
                        "</td>"+

                        "</tr>"
                    );
                });

                //конец таблицы
                box.append(
                    "</tbody>" +
                    "</table>"
                );

                //обновляем кол-во товаров в корзине
                if(all_number == 0){
                    basket.html('Товаров в корзине нет');
                }
                else{
                    basket.html('Товаров в корзине ' + all_number);
                }

                //обновляем итоговую сумму после удаления товара
                final.html(summ);
            }

            //если добавляем товар на единицу
            if(data.message == 'Увеличен на единицу'){

                //обновляем ячейку с кол-ом обновляемого товар в корзине
                init.text(data.number);

                //обновляем кол-во товаров в корзине
                basket.html('Товаров в корзине ' + data.numbers_in_basket);

                //обновляем итоговую сумму после увеличения товара на единицу
                final.html(Number(value)+data.price);

                //врубаем отправку формы по клику(необходимо при условии что кол-во товара было нулевым и мы вырубили отправку формы)
                $(minus).off('click');
            }

            //если уменьшаем товар на единицу
            if(data.message == 'Уменьшен на единицу'){

                //обновляем ячейку с кол-ом обновляемого товар в корзине
                init.text(data.number);

                //обновляем кол-во товаров в корзине
                basket.html('Товаров в корзине ' + data.numbers_in_basket);

                //если число данного товара равно единице
                if(data.number == 1){

                    //обновляем итоговую сумму после уменьшения товара на единицу
                    final.html(Number(value)-data.price);

                    //вырубаем отправку формы по клику, чтобы не было возможности сделать кол-во равным нулю
                    $(minus).click(function() {
                        return false;
                    });
                }
                else{
                    //обновляем итоговую сумму после уменьшения товара на единицу
                    final.html(Number(value)-data.price);
                }
            }


        }).on("ajax:error", function (xhr, data) {
            //как то можно обработать ошибку
        });
    }

});