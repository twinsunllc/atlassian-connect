require "atlassian/connect/controller"
require "atlassian/connect/engine"
require "atlassian/connect/version"

module Atlassian
  module Connect
    mattr_accessor :api_version
    self.api_version = 1

    mattr_accessor :enable_licensing

    mattr_accessor :key

    mattr_accessor :modules

    mattr_accessor :name

    mattr_accessor :post_install_url

    mattr_accessor :post_update_url

    mattr_accessor :scopes
    self.scopes = [
        'act_as_user', 'read', 'write'
    ]

    mattr_accessor :vendor_name
    mattr_accessor :vendor_url
  end
end
