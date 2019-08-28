Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/personality_test', to: 'tests#personality_traits'
  get '/emotions_test', to: 'tests#emotions'
  get '/word_cloud_test', to: 'test_word_clouds#show_input'
  get '/get_word_cloud_input', to: 'test_word_clouds#get_input'
end
