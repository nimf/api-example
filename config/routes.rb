Rails.application.routes.draw do
  scope module: :v1, constraints: ApiConstraint.new(version: 1) do
    resources :contacts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
