Rails.application.routes.draw do
  #devise_for :admins
  resources :notes do
    resources :comments

    member do
      get 'mark_as_important/:status', to: "notes#mark_as_important", as: "mark_as_important"
      get 'share_note'
      get 'request_edit_permission/:user_id', to: "notes#request_edit_permission", as: "request_edit_permission"
      get 'assign_edit_permission/:user_id', to: "notes#assign_edit_permission", as: "assign_edit_permission"
      post 'send_note'
    end

    collection do
      get 'autosave/:status', to: "notes#autosave", as: "autosave"
      post 'search', to: "notes#search", as: "search"
    end
  end
  resources :profile, only: %i[show edit update]

  devise_for :users
  devise_for :admins

  root 'notes#index'
  # devise_scope :user do
  #   authenticated :user do
  #     root 'notes#index', as: :authenticated_root
  #   end
  #
  #   unauthenticated do
  #     root 'devise/sessions#new', as: :unauthenticated_root
  #   end
  # end

  # devise_scope :admin do
  #   authenticated :admin do
  #     root 'admin#index', as: :authenticated_admin_root
  #   end
  #
  #   unauthenticated do
  #     root 'admin/sessions#new', as: :unauthenticated_admin_root
  #   end
  #
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
