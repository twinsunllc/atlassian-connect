class CreateAtlassianConnectAppInstalls < ActiveRecord::Migration[6.1]
  def change
    create_table :atlassian_connect_app_installs do |t|
      t.string :base_url
      t.string :client_key
      t.text :description
      t.string :installed_user_key
      t.string :plugins_version
      t.string :server_version
      t.string :service_entitlement_number
      t.string :shared_secret
      t.datetime :uninstalled_at
      t.timestamps
    end
  end
end
