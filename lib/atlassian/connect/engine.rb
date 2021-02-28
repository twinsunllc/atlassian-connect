module Atlassian
  module Connect
    class Engine < ::Rails::Engine
      isolate_namespace Atlassian::Connect

      initializer :append_migrations do |app|
        # This prevents migrations from being loaded twice from the inside of the
        # gem itself (dummy test app)
        if app.root.to_s !~ /#{root}/
          config.paths['db/migrate'].expanded.each do |migration_path|
            app.config.paths['db/migrate'] << migration_path
          end
        end
      end

      initializer 'atlassian_connect.action_controller' do
        ActiveSupport.on_load :action_controller do
          helper Atlassian::Connect::ApplicationHelper
        end
      end

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :fabrication, :dir => "spec/fabricators"
        g.fabricator_path = 'spec/fabricators'
      end
    end
  end
end
