Letsdosomething::Application.routes.draw do
  resources :complaints
  match     'complaints/:id/advocated_by_user', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#advocated_by_user', 
      :via => [ :post ] }

  match     'complaints/:id/relinquished_by_user', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#relinquished_by_user', 
      :via => [ :post ] }

  devise_for :users
  root  to: "welcome#index"
end
