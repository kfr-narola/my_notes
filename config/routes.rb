Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, skip: %i[registrations passwords],
                      controllers: { sessions: 'admins/sessions' }

  authenticated :admin do
    root 'admins/dashboard#index', as: :authenticated_admin_root
  end


  devise_scope :user do
    authenticated :user do
      root 'notes#index'#, as: :authenticated_root
    end

    unauthenticated :user do
      root 'devise/sessions#new'#, as: :unauthenticated_root
    end
  end


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

  namespace :admins do
    resources :dashboard, only: %i[index]

    resources :notes, except: %i[create new] do
      get 'share_note'
    end

    resources :users
  end
end
