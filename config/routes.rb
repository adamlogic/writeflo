Writeflo::Application.routes.draw do

  resources :docs, path: 'wf' do
    get :share, on: :member
  end

  resources :versions, path: 'share', only: [] do
    resources :reviews do
      get :preview, on: :member
    end
  end

  resources :accounts, only: ['new']

  get 'share/:version_id' => 'reviews#new', as: :new_review
  get 'reviews/thanks' => 'reviews#thanks', as: :thanks
  get 'ping' => proc { |env| [200, {}, ["Pinged at #{Time.zone.now}"]] }

  root to: 'reviews#new'

end
