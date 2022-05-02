Rails.application.routes.draw do
  pages = %w(about terms privacy_policy)

  resources :stories, except: :show, shallow: true do
    resources :chapters, except: [:index, :show], shallow: true do
      resources :parts, except: :index  
    end
    resources :characters, except: :show
  end
  # resources :chapters do
  #   resources :parts
  # end
  # resources :chats

  root 'pages#about'
  pages.each do |page|
    get "#{page}", to: "pages##{page}"
  end
  resources :pages, only: [:edit, :update, :show]
  post 'tinymce_assets', to: 'tinymce_assets#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
