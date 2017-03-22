Rails.application.routes.draw do
  resources :contatos

  root 'contatos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
