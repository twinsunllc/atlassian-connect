module Atlassian
  module Connect
    class AppDescriptorController < ApplicationController
      def index
        @config = Atlassian::Connect.configuration
      end
    end
  end
end
