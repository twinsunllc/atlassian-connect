require "atlassian/connect/controller"
require "atlassian/connect/engine"
require "atlassian/connect/redirecting"
require "atlassian/connect/version"

module Atlassian
  module Connect
    class Configuration
      mattr_accessor :api_version
      mattr_accessor :description
      mattr_accessor :enable_licensing
      mattr_accessor :key
      mattr_accessor :links
      mattr_accessor :modules
      mattr_accessor :name
      mattr_accessor :post_install_url
      mattr_accessor :post_update_url
      mattr_accessor :scopes
      mattr_accessor :vendor_name
      mattr_accessor :vendor_url

      # Reset configuration to sane defaults.
      def self.reset
        self.api_version = 1
        self.enable_licensing = false
        self.key = 'TODO.CHANGE-ME'
        self.links = {}
        self.modules = {}
        self.name = 'TODO - CHANGE ME'
        self.scopes = %w(act_as_user read write)
      end

      self.reset
    end

    class << self
      attr_writer :configuration
    end

    module_function

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      validate_configuration
    end

    private

    def self.validate_configuration
      # validation rules derived from https://developer.atlassian.com/cloud/jira/platform/connect-app-descriptor/
      raise ArgumentError.new('Invalid value for `key`') unless /^[a-zA-Z0-9\-._]+$/.match?(configuration.key)
      raise ArgumentError.new('Value for `key` is too long') unless configuration.key.length <= 64

      if !configuration.api_version.nil?
        raise ArgumentError.new('Invalid value for `api_version`') unless configuration.api_version.is_a?(Integer)
      end

      raise ArgumentError.new('Invalid value for `enable_licensing`') unless configuration.enable_licensing.in?([true, false])
      raise ArgumentError.new('Invalid value for `name`') unless configuration.name.is_a?(String) && configuration.name.present?
    end
  end
end
