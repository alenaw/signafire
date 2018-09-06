Rails.application.routes.draw do
  get '/users/:name', to: 'users#read'
end
