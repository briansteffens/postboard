Rails.application.routes.draw do
  match 'b/:url_fragment' => 'boards#show', via: [:get]
  match 'b/:url_fragment' => 'boards#post', via: [:post]
  match 'b/:url_fragment/moderate' => 'boards#moderate_form', via: [:get]
  match 'b/:url_fragment/moderate' => 'boards#moderate', via: [:post]
  match 'b/:url_fragment/end_moderate' => 'boards#end_moderate', via: [:get]

  root 'boards#index'

  resources :posts
  resources :boards
end
