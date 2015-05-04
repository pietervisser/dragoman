Dummy::Application.routes.draw do
  get 'comments' => 'application#index'

  localize do
    namespace 'admin' do
      get 'customers' => 'application#index'
    end

    scope 'secret' do
      get 'payments' => 'application#index'
    end

    resources :products#, path_names: {edit: 'accept'}
    resource :account

    get '' => 'application#index', as: 'empty'

    namespace 'empty', path: '' do
      get 'books' => 'application#index'
    end
    resources :invitations, only: [] do
      member do
        get :edit, path: 'accept'
      end
    end

    resources :chairs, only: :index, path: 'seats'

  end

end