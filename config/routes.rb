Atlassian::Connect::Engine.routes.draw do
  resources :lifecycle, defaults: { format: :json }, only: [] do
    collection do
      post :disabled
      post :enabled
      post :installed
      post :uninstalled
    end
  end

  root to: 'app_descriptor#index', defaults: { format: :json }
end

Rails.application.routes.draw do
  AppDescriptorController = Atlassian::Connect::AppDescriptorController
  get '/atlassian-connect.json' => 'app_descriptor#index', defaults: { format: :json }
end
