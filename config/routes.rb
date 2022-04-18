Rails.application.routes.draw do
  pages = %w(about terms privacy_policy)

  root 'pages#home'
  pages.each do |page|
    get "#{page}", to: "pages##{page}"
  end
  resources :pages, only: [:edit, :update, :show]
  post 'tinymce_assets', to: 'tinymce_assets#create'

end
