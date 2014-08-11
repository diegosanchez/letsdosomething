Letsdosomething::Application.routes.draw do
  match     'complaints/:id/advocated_by_user', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#advocated_by_user', 
      :via => [ :post ] }

  match     'complaints/:id/relinquished_by_user', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#relinquished_by_user', 
      :via => [ :post ] }

  match     'complaints/most_popular', 
    { :defaults => { :format => 'json' },
      :to => 'complaints#most_popular', 
      :via => [ :get ] }

  resources :complaints

  match     'proofs/:id',
    { :to   => 'proofs#content',
      :as   => 'proof_content',
      :via  => [ :get ] }

  devise_for :users
  root  to: "welcome#index"
end
