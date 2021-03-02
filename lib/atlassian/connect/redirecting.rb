module ActionController::Redirecting
  def redirect_to(options = {}, response_options = {})
    raise ActionControllerError.new("Cannot redirect to nil!") unless options
    raise AbstractController::DoubleRenderError if response_body

    if @app_install.present?
      # Add a request identifier to the redirect URL so we can keep track of which AppInstall initiated the request.
      request_identifier = @app_install.generate_request_identifier
      if options.is_a?(String)
        options = "#{options}?&#{Atlassian::Connect::Controller::REQUEST_ID_PARAM_NAME}=#{request_identifier}"
      elsif options.is_a?(Hash)
        options[Atlassian::Connect::Controller::REQUEST_ID_PARAM_NAME] = request_identifier
      else
        Rails.logger.warn "Unhandled options type for `redirect_to`. The `options` argument is a #{options.class}"
      end
    end

    self.status        = _extract_redirect_to_status(options, response_options)
    self.location      = _compute_redirect_to_location(request, options)
    self.response_body = "<html><body>You are being <a href=\"#{ERB::Util.unwrapped_html_escape(response.location)}\">redirected</a>.</body></html>"
  end
end