$(document).ready(function() {

    //формируем ЧПУ
    $('body').on('click', '.new_product', function() {

        var product_name = $("input#product_product_title").val();

        String.prototype.replaceArray = function(find, replace) {
            var replaceString = this;
            var regex;
            for (var i = 0; i < find.length; i++) {
                regex = new RegExp(find[i], "g");
                replaceString = replaceString.replace(regex, replace[i]);
            }
            return replaceString;
        };

        var textarea = $(this).val();
        var rus = ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', ' '];
        var lat = ['A', 'B', 'V', 'G', 'D', 'E', 'E', 'Gh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'H', 'C', 'Ch', 'Sh', 'Sch', 'Y', 'Y', 'Y', 'E', 'Yu', 'Ya', 'a', 'b', 'v', 'g', 'd', 'e', 'e', 'gh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'h', 'c', 'ch', 'sh', 'sch', 'y', 'y', 'y', 'e', 'yu', 'ya', '-'];
        product_name = product_name.replaceArray(rus, lat);

        product_name = product_name.replace(/\./g, '-');
        product_name = product_name.replace(/\,/g, '-');
        product_name = product_name.replace(/\:/g, '-');
        product_name = product_name.replace(/\//g, '-');
        product_name = product_name.replace(/\(/g, '-');
        product_name = product_name.replace(/\)/g, '-');

        $("input#product_friendly_url").val(product_name.toLowerCase());
    });



    //формируем attribute_name для нового аттрибута товара
    $('body').on('click', '.new_productatr', function() {

        var attribute_name = $("input#productatr_attribute_rus_name").val();

        String.prototype.replaceArray = function(find, replace) {
            var replaceString = this;
            var regex;
            for (var i = 0; i < find.length; i++) {
                regex = new RegExp(find[i], "g");
                replaceString = replaceString.replace(regex, replace[i]);
            }
            return replaceString;
        };

        var textarea = $(this).val();
        var rus = ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', ' '];
        var lat = ['A', 'B', 'V', 'G', 'D', 'E', 'E', 'Gh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'H', 'C', 'Ch', 'Sh', 'Sch', 'Y', 'Y', 'Y', 'E', 'Yu', 'Ya', 'a', 'b', 'v', 'g', 'd', 'e', 'e', 'gh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'h', 'c', 'ch', 'sh', 'sch', 'y', 'y', 'y', 'e', 'yu', 'ya', '-'];
        attribute_name = attribute_name.replaceArray(rus, lat);

        attribute_name = attribute_name.replace(/\./g, '-');
        attribute_name = attribute_name.replace(/\,/g, '-');
        attribute_name = attribute_name.replace(/\:/g, '-');
        attribute_name = attribute_name.replace(/\//g, '-');
        attribute_name = attribute_name.replace(/\(/g, '-');
        attribute_name = attribute_name.replace(/\)/g, '-');

        $("input#productatr_attribute_name").val(attribute_name.toLowerCase());
    });

/////////////////////////// обрабатываем возможные формы добавления товара через выпадающий список ///////////////////////////

    $("#select-card select")
        .change(function () {
            var select = $('select').val();
            $.post(
                '/products'+ '/' + select,
                function (data) {

                    var box = $('.select-card');
                    box.empty();

                    //закидываем поля от карточки в форму
                    $.each(data.attr_names, function(key, value){
                        box = $('.form-ajax');
                        box.append(
                            '<div class="form"><input required="required" placeholder="'+value.attribute_rus_name+'" type="text" name="product['+value.attribute_name+']" id="product_'+value.attribute_name+'"></div>'
                        );
                    });

                }
            )
        }).change();


});


