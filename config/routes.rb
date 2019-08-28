Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/personality_test', to: 'tests#personality_traits'
  get '/emotions_test', to: 'tests#emotions'
  root 'welcome#index'
  get '/get_results', to: 'welcome#get_artist'
end
