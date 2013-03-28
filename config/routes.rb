Writeflo::Application.routes.draw do

  resources :docs, path: 'wf' do
    get :share, on: :member
  end

  resources :versions, only: [] do
    resources :reviews do
      get :preview, on: :member
    end
  end

  get 'share/:version_id' => 'reviews#new', as: :new_review

  root to: 'docs#new'

end
