Rails.application.routes.draw do
  get  '/users/:name', to: 'users#read'
  get  '/results',     to: 'elastic_results#query'
end
