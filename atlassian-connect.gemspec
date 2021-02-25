require_relative "lib/atlassian/connect/version"

Gem::Specification.new do |spec|
  spec.name        = "atlassian-connect"
  spec.version     = Atlassian::Connect::VERSION
  spec.authors     = ["Twin Sun"]
  spec.email       = ["contact@twinsunsolutions.com"]
  spec.homepage    = "https://twinsunsolutions.com"
  spec.summary     = "Atlassian Connect engine for Ruby on Rails."
  spec.description = "Atlassian Connect engine for Ruby on Rails."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/twinsunllc/atlassian-connect-rails"
  spec.metadata["changelog_uri"] = "https://www.github.com/twinsunllc/atlassian-connect-rails/releases"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3"
end
