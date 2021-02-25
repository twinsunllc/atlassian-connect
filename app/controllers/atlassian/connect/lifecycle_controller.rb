module Atlassian
  module Connect
    class LifecycleController < ApplicationController
      skip_before_action :verify_authenticity_token

      def disabled
        logger.info "Disablement initiated for baseUrl[#{params[:baseUrl]}]."
        respond_to do |format|
          format.json { head :ok }
        end
      end

      def enabled
        logger.info "Enablement initiated for baseUrl[#{params[:baseUrl]}]."
        respond_to do |format|
          format.json { head :ok }
        end
      end

      def installed
        logger.info "Installation initiated for baseUrl[#{params[:baseUrl]}]."
        respond_to do |format|
          begin
            Atlassian::Connect::AppInstall.create!({
              base_url: params.require(:baseUrl),
              client_key: params.require(:clientKey),
              description: params[:description],
              installed_user_key: params[:userKey],
              plugins_version: params[:pluginsVersion],
              server_version: params[:serverVersion],
              service_entitlement_number: params[:serviceEntitlementNumber],
              shared_secret: params.require(:sharedSecret)
            })
          rescue => error
            logger.error "Can not finish installation for params #{params.to_json}. Raised #{error.class}: #{error.message}"
            format.json { render json: {error: 'Can not finish installation. Please try again.'}, status: :bad_request }
          end
          format.json { render json: {}, status: :ok }
        end
      end

      def uninstalled
        logger.info "Uninstall initiated for baseUrl[#{params[:baseUrl]}]."
        begin
          app_install = Atlassian::Connect::AppInstall.where(client_key: params.require(:clientKey), uninstalled_at: nil).last
          if app_install.present?
            app_install.uninstalled_at = DateTime.now
            app_install.save!
          else
            logger.warn "No current AppInstall found to uninstall for baseUrl[#{params[:baseUrl]}]."
          end
        rescue => error
          logger.error "Can not find or update AppInstall for params #{params.to_json}."
        end

        respond_to do |format|
          format.json { head :ok }
        end
      end
    end
  end
end