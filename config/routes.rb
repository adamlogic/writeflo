Writeflo::Application.routes.draw do
  resources :docs


  root to: 'docs#new'
end
