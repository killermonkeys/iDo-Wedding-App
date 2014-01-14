OldIdo::Application.routes.draw do
  match 'rsvp' => 'sessions#new', :as => :login, :via => :get
  match 'rsvp' => 'sessions#create', :as => :login, :via => :post
  match 'menuchoices' => 'guests#menu', via: [:get, :post]
  match 'logout' => 'sessions#destroy', :as => :logout
  root to: 'sessions#new'

  resource :guest, :only => [:show, :edit, :update]
  
  namespace :admin do
    resources :guests do
      collection do
        get :import
        post :import
      end
    
      resource :address
      resource :rsvp
      resources :gifts
    end

    resources :addresses, :only => :index
    resources :gifts, :only => :index
    resources :rsvps, :only => :index
    resources :thank_yous, :only => :index
  end
end
