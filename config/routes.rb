Writeflo::Application.routes.draw do

  resources :docs do
    member do
      get :feedback
      get :share
    end
  end

  root to: 'docs#new'

end
