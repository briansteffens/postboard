Rails.application.routes.draw do
  match 'b' => 'boards#new', via: [:get]
  match 'b' => 'boards#create', via: [:post]
  match 'b/:url_fragment' => 'boards#show', via: [:get]
  match 'b/:url_fragment/edit' => 'boards#edit', via: [:get, :post]
  match 'b/:url_fragment/moderate' => 'boards#moderate_form', via: [:get]
  match 'b/:url_fragment/moderate' => 'boards#moderate', via: [:post]
  match 'b/:url_fragment/end_moderate' => 'boards#end_moderate', via: [:get]
  match 'b/:url_fragment' => 'boards#destroy', via: [:delete]

  match 'b/:url_fragment/posts' => 'posts#create', via: [:post], :as => :posts
  match 'b/:url_fragment/posts/:id' => 'posts#destroy', via: [:delete]

  root 'boards#index'

  # TODO: Remove this. Github issue #1
  resources :boards
end
