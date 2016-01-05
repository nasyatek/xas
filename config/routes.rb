Rails.application.routes.draw do

  resources :network_sets

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'welcome#dashboard', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root 'welcome#dashboard'

  resources :todo_lists
  resources :settings
  resources :groups
  resources :servers
  resources :xas_sets
  resources :network_sets
  resources :xymon_sets
  resources :xmail_sets
  resources :xapachi_sets

  get 'welcome/dashboard'
  get 'welcome/monitor'
  get 'console/index'
  get 'welcome/disk_info'
  get 'welcome/alarms'
  get 'welcome/temp_history'

  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

  # All
  post '/ajax/start_all_system' => 'console#start_all_system'
  post '/ajax/stop_all_system' => 'console#stop_all_system'

  # Files
  post '/ajax/recreate_xas_host_file' => 'console#recreate_xas_host_file'
  post '/ajax/recreate_apache_config' => 'console#recreate_apache_config'
  post '/ajax/recreate_xymon_alerts' => 'console#recreate_xymon_alerts'
  post '/ajax/recreate_xymon_html' => 'console#recreate_xymon_html'
  post '/ajax/recreate_xymon_mail' => 'console#recreate_xymon_mail'

  # Servers #
  # Apache
  post '/ajax/apache_start' => 'console#apache_start'
  post '/ajax/apache_stop' => 'console#apache_stop'
  post '/ajax/apache_restart' => 'console#apache_restart'
  post '/ajax/apache_status' => 'console#apache_status'

  # Xymon
  post '/ajax/xymon_start' => 'console#xymon_start'
  post '/ajax/xymon_stop' => 'console#xymon_stop'
  post '/ajax/xymon_restart' => 'console#xymon_restart'
  post '/ajax/xymon_status' => 'console#xymon_status'

  # Postfix
  post '/ajax/postfix_start' => 'console#postfix_start'
  post '/ajax/postfix_stop' => 'console#postfix_stop'
  post '/ajax/postfix_restart' => 'console#postfix_restart'
  post '/ajax/postfix_status' => 'console#postfix_status'
end
