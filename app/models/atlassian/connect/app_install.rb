module Atlassian::Connect
  class AppInstall < ApplicationRecord
    validates :base_url, presence: true, allow_blank: false
    validates :client_key, presence: true, allow_blank: false
    validates :shared_secret, presence: true, allow_blank: false
  end
end
