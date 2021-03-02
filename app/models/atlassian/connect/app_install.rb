module Atlassian::Connect
  # AppInstalls represent a specific instance installation of our app
  # (e.g., a new "install" event on a Jira Cloud instance). This data is used to build authenticated requests to
  # Atlassian Cloud REST API endpoints.
  class AppInstall < ApplicationRecord
    validates :base_url, presence: true, allow_blank: false
    validates :client_key, presence: true, allow_blank: false
    validates :shared_secret, presence: true, allow_blank: false

    # Generates a new request identifier to associate with the AppInstall.
    # We generate request identifiers to pass around in URL params. This is to help us maintain some semblance of a
    # user session since Atlassian Cloud apps run in an iframe that does not natively support cookies.
    def generate_request_identifier
      request_id = "#{SecureRandom.uuid}#{self.id}#{rand(1000...9999)}"
      Rails.cache.write("request-id-#{request_id}", self.id)
      return request_id
    end

    # Finds an AppInstall by an associated request identifier.
    # We generate request identifiers to pass around in URL params. This is to help us maintain some semblance of a
    # user session since Atlassian Cloud apps run in an iframe that does not natively support cookies.
    def self.find_by_request_identifier(request_identifier)
      app_install_id = Rails.cache.read("request-id-#{request_identifier}")
      return app_install_id.present? ? Atlassian::Connect::AppInstall.find(app_install_id) : nil
    end
  end
end
