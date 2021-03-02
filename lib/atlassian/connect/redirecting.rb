module ActionController::Redirecting
  def redirect_to(options = {}, response_options = {})
    raise ActionControllerError.new("Cannot redirect to nil!") unless options
    raise AbstractController::DoubleRenderError if response_body

    if @app_install.present?
      Rails.logger.info("REDIRECTING: #{@app_install}")
      if options.is_a?(String)
        options = "#{options}?&#{Atlassian::Connect::Controller::REQUEST_ID_PARAM_NAME}=#{@app_install.generate_request_id}"
      elsif options.is_a?(Hash)
        options[Atlassian::Connect::Controller::REQUEST_ID_PARAM_NAME] = @app_install.generate_request_id
      else
        Rails.logger.warn "Unhandled options type for `redirect_to`. Options are a #{options.class}"
      end
    end

    self.status        = _extract_redirect_to_status(options, response_options)
    self.location      = _compute_redirect_to_location(request, options)
    self.response_body = "<html><body>You are being <a href=\"#{ERB::Util.unwrapped_html_escape(response.location)}\">redirected</a>.</body></html>"
  end
end