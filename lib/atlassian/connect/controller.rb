module Atlassian
  module Connect
    module Controller
      extend ActiveSupport::Concern
      included do
        before_action :determine_app_install
        before_action :ensure_licensed
      end

      REQUEST_ID_PARAM_NAME = :request_identifier.freeze


      @app_install = nil

      protected

      # Sets <tt>@app_install</tt> based on either the request's provided JWT or a request identifier parameter.
      def determine_app_install
        jwt_request_token = params[:jwt] ||
            (request.headers['Authorization'] ? request.headers['Authorization'].sub!('JWT ', '') : nil)

        if jwt_request_token
          # detect the AppInstall based on the request's provided JWT.
          claim, jwt_header = Atlassian::Jwt.decode(jwt_request_token, nil, false)
          @app_install = Atlassian::Connect::AppInstall.where(client_key: claim['iss'], uninstalled_at: nil).order(created_at: :asc).last
          raise "No valid AppInstall found for client_key #{claim['iss']}" if @app_install.nil?
        elsif params[REQUEST_ID_PARAM_NAME]
          # fall back to detecting the AppInstall based on a request identifier parameter.
          @app_install = Atlassian::Connect::AppInstall.find(params[REQUEST_ID_PARAM_NAME])
        else
          raise "No token provided to determine AppInstall."
        end
      end

      def ensure_licensed
        return if ignore_jira_licensing?

        candidate_qsh = Atlassian::Jwt.create_query_string_hash(request.fullpath, request.method, request.base_url)
        if !candidate_qsh.eql?(claim['qsh'])
          raise "Invalid query string hash for params #{params.to_json}"
        end

        claim, jwt_header = Atlassian::Jwt.decode(jwt_request_token, @app_install.shared_secret)
        if claim.key?('exp') && Time.now > Time.at(claim['exp'].to_i) # exp is optional but should be checked.
          raise "Expired claim #{claim.to_json} for params #{params.to_json}"
        end

        lic = params[:lic]
        Rails.logger.debug "License Param (lic): #{lic}"
        if lic.present? && !'active'.eql?(lic)
          Rails.logger.error "No active license for AppInstall: #{@app_install.base_url})"
          flash[:license_error] = "No active license for AppInstall: #{@app_install.base_url})"
        end
      end

      private

      def ignore_jira_licensing?
        ENV['IGNORE_JIRA_LICENSING'].eql?('true')
      end
    end
  end
end