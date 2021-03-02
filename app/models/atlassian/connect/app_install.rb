module Atlassian::Connect
  class AppInstall < ApplicationRecord
    validates :base_url, presence: true, allow_blank: false
    validates :client_key, presence: true, allow_blank: false
    validates :shared_secret, presence: true, allow_blank: false

    def generate_request_id
      request_id = "#{SecureRandom.uuid}#{self.id}#{rand(1000...9999)}"
      Rails.cache.write("request-id-#{request_id}", self.id)
      return request_id
    end

    def self.find_by_request_id(request_id)
      app_install_id = Rails.cache.read("request-id-#{request_id}")
      return app_install_id.present? ? Atlassian::Connect::AppInstall.find(app_install_id) : nil
    end
  end
end
