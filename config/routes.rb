Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'costs#index'
  resources :costs
  resources :incomes
  get '/costs/daily', to: 'costs#daily', param: :date
end
