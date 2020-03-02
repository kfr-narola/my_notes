Rails.application.routes.draw do
  # devise_for :admins
  resources :notes do
    resources :comments
  end
  #
  devise_for :users

  get 'admin/index'
  get 'admin/manage_users'
  get 'admin/manage_notes'
  get 'comments/pagination/:page/:note', to: "comments#pagination", as:"pagination"
  get 'profile/', to:"profile#index", as:"profile"
  get 'notes/mark_as_important/:id/:important', to: "notes#mark_as_important", as:"mark_important"
  get 'notes/autosave/:autosave', to: "notes#autosave", as:"autosave"
  get 'notes/sharenote/:id', to: "notes#form_share_note", as:"form_share_note"
  get 'notes/request_note_edit/:id/:user', to: "notes#request_note_edit", as:"request_note_edit"
  get 'notes/assign_note_edit/:id/:user', to: "notes#assign_note_edit", as:"assign_note_edit"

  post 'notes/sharenote/:id', to: "notes#sharenote", as:"sharenote"
  patch 'profile/edit/', to:"profile#edit", as:"profile_edit"
  post 'notes/search/', to: "notes#search", as:"search"

  root to: 'notes#index'
  #
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   # registrations: 'users/registrations',
  #   passwords: 'users/passwords'
  #
  # }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
