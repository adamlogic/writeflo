Writeflo::Application.routes.draw do

  resources :docs, path: 'wf' do
    get :share, on: :member
  end

  resources :versions, path: 'share', only: [] do
    resources :reviews do
      get :preview, on: :member
    end
  end

  get 'share/:version_id' => 'reviews#new', as: :new_review
  get 'reviews/thanks' => 'reviews#thanks', as: :thanks

  root to: 'docs#new'

end
