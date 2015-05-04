Dummy::Application.routes.draw do
  get 'comments' => 'application#index'

  localize do
    namespace 'admin' do
      get 'customers' => 'application#index'
    end

    scope 'secret' do
      get 'payments' => 'application#index'
    end

    resources :products
    resource :account

    get '' => 'application#test', as: 'empty'
  end

end