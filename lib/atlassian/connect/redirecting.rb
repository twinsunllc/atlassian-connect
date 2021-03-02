module ActionController::Redirecting
  def redirect_to(options = {}, response_status = {})
    raise ActionControllerError.new("Cannot redirect to nil!") unless options
    raise AbstractController::DoubleRenderError if response_body

    # TODO add session var.

    self.status        = _extract_redirect_to_status(options, response_status)
    self.location      = _compute_redirect_to_location(options)
    self.response_body = "<html><body>You are being <a href=\"#{ERB::Util.h(location)}\">redirected</a>.</body></html>"

  end
end