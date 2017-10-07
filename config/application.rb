require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Energycity
  class Application < Rails::Application

    #часовой пояс
    config.time_zone = 'Moscow'

    #по умолчанию создаем файлы slim
    config.generators do |g|
      g.template_engine :slim
    end


    #для русской локали
    config.i18n.default_locale = :ru
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    #для редиректов
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
     #убираем слеши в конце урла
     r301 %r{^/(.*)/$}, '/$1'
    end

  end
end
