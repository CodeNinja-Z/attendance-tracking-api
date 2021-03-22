require 'rails/application_controller'

class WelcomeController < Rails::ApplicationController
  def index
    render file: Rails.root.join('app', 'views', 'welcome', 'index.html.erb')
  end
end
