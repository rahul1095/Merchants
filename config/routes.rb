Rails.application.routes.draw do
  devise_for :users
  resources :merchants
  root 'merchants#index'
 namespace :api do
	   namespace :v1 do
	   	 resources :register_user, defaults: {format: 'json'} do
	   	 	collection do
	   	 		 post 'create_user'
	   	 		post 'login'
	   	 		# post 'index'
	 
	   	 	end	
	   	 end	
	   end
    end 	

end


