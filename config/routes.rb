Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/personality_test', to: 'tests#personality_traits'
  get '/emotions_test', to: 'tests#emotions'
  get '/lyrics_finder_test', to: 'tests#lyrics_finder'
end
