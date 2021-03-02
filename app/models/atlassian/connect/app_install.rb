module Atlassian::Connect
  # AppInstalls represent a specific instance installation of our app
  # (e.g., a new "install" event on a Jira Cloud instance). This data is used to build authenticated requests to
  # Atlassian Cloud REST API endpoints.
  class AppInstall < ApplicationRecord
    validates :base_url, presence: true, allow_blank: false
    validates :client_key, presence: true, allow_blank: false
    validates :shared_secret, presence: true, allow_blank: false

    # Send a request to the Atlassian Cloud API on behalf of the requesting AppInstall instance.
    # `path:` endpoint URL, excluding base path/domain
    # `type:` request type (e.g., `:GET` or `:POST`)
    # `body:` request body (optional)
    def api_request(path:, type:, body: nil)
      claim, jwt = generate_client_claim_and_jwt(path: path, type: type.to_s.upcase)
      base_url = self.base_url

      uri = URI("#{base_url}#{path}")
      req = nil
      case type
      when :DELETE
        req = Net::HTTP::Delete.new(uri.request_uri)
      when :GET
        req = Net::HTTP::Get.new(uri.request_uri)
      when :HEAD
        req = Net::HTTP::Head.new(uri.request_uri)
      when :OPTIONS
        req = Net::HTTP::Options.new(uri.request_uri)
      when :PATCH
        req = Net::HTTP::Patch.new(uri.request_uri)
      when :POST
        req = Net::HTTP::Post.new(uri.request_uri)
      when :PUT
        req = Net::HTTP::Put.new(uri.request_uri)
      else
        raise "Invalid type `#{type}` provided for request"
      end

      req.body = body unless body.blank?
      req.initialize_http_header({
        "Authorization" => "JWT #{jwt}",
        "Accept" => "application/json",
        "Content-Type" => "application/json",
      })

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      return http.request(req)
    end

    # Generates a new request identifier to associate with the AppInstall.
    # We generate request identifiers to pass around in URL params. This is to help us maintain some semblance of a
    # user session since Atlassian Cloud apps run in an iframe that does not natively support cookies.
    def generate_request_identifier
      request_id = "#{SecureRandom.uuid}#{self.id}#{rand(1000...9999)}"
      Rails.cache.write("request-identifier-#{request_id}", self.id)
      return request_id
    end

    # Finds an AppInstall by an associated request identifier.
    # We generate request identifiers to pass around in URL params. This is to help us maintain some semblance of a
    # user session since Atlassian Cloud apps run in an iframe that does not natively support cookies.
    def self.find_by_request_identifier(request_identifier)
      app_install_id = Rails.cache.read("request-identifier-#{request_identifier}")
      return app_install_id.present? ? Atlassian::Connect::AppInstall.find(app_install_id) : nil
    end

    private

    # Generate a new claim and JWT for use in a request to the Atlassian Cloud REST API.
    def generate_client_claim_and_jwt(path:, type:)
      issuer = self.client_key
      base_url = self.base_url

      claim = Atlassian::Jwt.build_claims(Atlassian::Connect.configuration.key, path, type, base_url, nil, (Time.now + 10.minutes).to_i)
      jwt = Atlassian::Jwt.encode(claim, self.shared_secret)

      return claim, jwt
    end
  end
end
