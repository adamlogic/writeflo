Writeflo::Application.routes.draw do

  resources :docs, path: 'wf' do
    get :share, on: :member
  end

  get 'wf/:doc_id/v:version' => 'reviews#new', as: :new_review

  root to: 'docs#new'

end
