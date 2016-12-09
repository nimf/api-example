Rails.application.routes.draw do
  namespace :v1 do
    resources :contacts
  end
  scope :docs do
    namespace :v1 do
      resources :apidocs, only: :index
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
