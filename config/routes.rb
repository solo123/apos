PosDaily::Application.routes.draw do
  comfy_route :cms_admin, :path => '/cms-admin'

  devise_for :users

  resources :merchants
  resources :ttts
  resources :my_trades
	resources :clients do
    patch :del_merchant, :on => :member
    patch :add_merchant, :on => :member
	end

  resources :users do
    post :add, :on => :collection
    patch :del_agent_merchant, :on => :member
    patch :add_agent_merchant, :on => :member
		get :mock, :on => :member
  end

  resources :trades do
    collection do
      post :import
      get :del
      get :submit
      get :rm
    end
  end

	resources :reports do
		collection do
			get :monthly
			get :daily
			post :daily
			get :agents
			post :agents
			get :merchants
			post :merchants
			get :merchant
		end
	end

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false
end
