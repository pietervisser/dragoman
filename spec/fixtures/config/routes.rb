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

    # shallow routes
    scope 'fast', shallow_path: 'fast' do
      resources :cars, :only => [:index] do
        resources :drivers, :only => [:show], shallow: true
      end
    end

    # route with blank translation
    get 'music' => 'application#index'

  end

end