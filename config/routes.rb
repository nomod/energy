Rails.application.routes.draw do

  root 'main#index'

  #регистрация
  get '/signup',  to: 'users#new'
  #вход
  get '/signin',  to: 'sessions#new'
  #выход
  delete '/signout', to: 'sessions#destroy'

  resources :baskets
  resources :users

  #дополнительный маршрут, который распознает /users/id/confirm_email с GET и направит в экшн confirm_email контроллера UsersController
  resources :users do
    get 'confirm_email', on: :member
  end

  #сброс пароля
  resources :resets, only: [:new, :create, :edit, :update]

  #обновление email
  resources :update_emails, only: [:edit, :update]

  resources :sessions, only: [:new, :create, :destroy]

  get '/categories',                        to: 'categories#index'
  get '/categories/new',                    to: 'categories#new'
  post '/categories',                       to: 'categories#create'
  get '/:category_id/edit',                 to: 'categories#edit'

  #выбор формы карточки товара через ajax при добавлении товара
  post '/products/:id',                     to: 'products#select_card'


  #для добавления товара в корзину
  post '/:category_id/:id',                 to: 'baskets#add_basket'


  #добавляем новое поле в карточку товара / удаляем поле из карточки
  post '/cards/:id',                        to: 'cards#create_input_card'

  resources :search, only: [:index]
  #переделываем запрос get на post для index страницы - гавёно, но при get запросе при поиске в строке передается параметр "utf8=✓" - хз как от него избавиться
  post '/search',                           to: 'search#index'

  resources :products
  resources :images
  resources :cards
  resources :productatrs

  resources :categories, path: '/' do #убираем название контроллера из url
    resources :subcategories, path: '/', only: [:show] do
      resources :products, path: '/', only: [:show]
    end
  end




end