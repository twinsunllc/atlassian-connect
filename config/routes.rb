Atlassian::Connect::Engine.routes.draw do
  resources :lifecycle, defaults: { format: :json }, only: [] do
    collection do
      post :disabled
      post :enabled
      post :installed
      post :uninstalled
    end
  end
end
