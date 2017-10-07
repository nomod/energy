class SubcategoriesController < ApplicationController

  def show

    #для формы добавления товара в корзину
    @order = Order.new

################  если вложенность категория - подкатегория   ################

    #текущая подкатегория
    @subcategory = Category.find_by_friendly_url(params[:id])
    #ее родительская категория
    @category = Category.find_by_friendly_url(params[:category_id])

####################################################################


################  если вложенность категория - товар   ################

    #текущий товар
    @product = Product.find_by_friendly_url(params[:id])
    #его родительская категория
    @category = Category.find_by_friendly_url(params[:category_id])

####################################################################

######### если вложенность категория - подкатегория #########
    if @subcategory && @category

      #если название категории и вложенной категории совпадают
      if @subcategory.friendly_url == @category.friendly_url
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found

      #если категория и подкатегория обе родильские или урл вида подкатегория/категория
      elsif @subcategory.parent_id == 0 && @category.parent_id == 0 || @subcategory.parent_id == 0 && @category.parent_id != 0
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found

      #иначе продолжаем
      else

        #если подкатегория не родительская(а она по умолчанию такая и должна быть)
        if @subcategory.parent_id != 0

          #то запускаем цикл и складываем туда родительские категории пока не дойдем до самой верхней
          @main_cat = [@subcategory]
          i = 0
          while !@main_cat[i].parent.nil?
            @main_cat[@main_cat.size] = @main_cat[i].parent
            i+=1
          end
        end

        #если найденная родительская категория у подкатегории действительно её родительская, то продолжаем
        if @main_cat.last.id == @category.id
          #смотрим есть ли у нее подкатегории
          @sub_subcategory = @subcategory.children

          #товары
          @products = Product.where(category_id: @subcategory.id)

        #иначе 404
        else
          render file: "#{Rails.root}/public/404", layout: false, status: :not_found
        end

      end


    ######### если вложенность категория - товар #########
    elsif @category && @product

      #значения доп.характеристик товара
      @attr = Product_With_Attribute.where(product_id: @product.id)

      #id доп характеристик товара
      @attr_ids = []
      @attr.each do |at|
        @attr_ids.push(at.product_atrs_id)
      end

      #вынимаем сами доп.характеристики товара по их id
      @attr_obj = []
      @attr_ids.each do |id|
        @atr = Productatr.where(id: id)
        @attr_obj.push(@atr)
      end

      #вынимаем названия доп.характеристик товара
      @attr_names = []
      @attr_obj.each do |obj|
        obj.each do |name|
          @attr_names.push(name.attribute_rus_name)
        end
      end

      #если название категории и товара совпадают или урл вида подкатегория/товар (а должна быть по идеи категория/товар)
      if @category.friendly_url == @product.friendly_url || @category.parent_id != 0
        render file: "#{Rails.root}/public/404", layout: false, status: :not_found

      #иначе продолжаем
      else

        #если товар принадлежит категории
        if @category.id == @product.category_id
          @product

        #иначе 404
        else
          render file: "#{Rails.root}/public/404", layout: false, status: :not_found
        end

      end


    ######### иначе 404 #########
    else
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end

  end


end