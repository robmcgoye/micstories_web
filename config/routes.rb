Rails.application.routes.draw do
  pages = %w(about terms privacy_policy)

  resources :stories, except: :show, shallow: true do
    resources :chapters, except: [:index, :show], shallow: true do
      resources :parts, except: :index, shallow: true do
        resources :posts, except: [:show, :index] 
      end  
    end
    resources :characters, except: :show
  end

  root 'pages#index'
  pages.each do |page|
    get "#{page}", to: "pages##{page}"
  end
  resources :pages, only: [:edit, :update, :show]
  post 'tinymce_assets', to: 'tinymce_assets#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :settings, only: [:new, :create, :edit, :update]
  # get 'import', to: 'import#index'
  # post 'process', to: 'import#add_data'

end
