# Atlassian::Connect
Atlassian Connect integration for Ruby on Rails.

This provides the following features:
 - Connect App Descriptor
 - Lifecycle Event Webhooks (enabled, disabled, installed, uninstalled)
 - Database tracking of app installs and uninstalls
 - JWT authentication and request management

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'atlassian-connect', github: 'twinsunllc/atlassian-connect', branch: 'main'
```

And then execute:
```bash
$ bundle
```

Execute the following to upgrade your database so you can track app installs:

```bash
bundle exec rake db:migrate
```

Ensure you have the Rails cache enabled. By default in development, you can toggle caching with the following command:

```bash
rails dev:cache
```  

Add the following to your view layout's `<head>` section:

```ruby
<%= atlassian_connect_scripts %>
```

Add the following to your `config/routes.rb`:

```ruby
mount Atlassian::Connect::Engine, at: '/atlassian'
```

## Configuration

Add a `config/initializers/atlassian_connect.rb` file. You can specify any of the following settings, which control your App Descriptor:
```ruby
Atlassian::Connect.configure do |config|
  config.description = "Copies project settings and issues into new projects."
  config.enable_licensing = true
  config.key = 'com.example.jira.example-app'
  config.links = {}
  config.modules = {}
  config.name = 'My App for Jira Cloud'
  config.scopes << 'admin'
  config.vendor_name = 'My Company'
  config.vendor_url = 'https://example.com'
end
```

## Usage
This gem generates request identifiers to pass around in URL params throughout an Atlassian Connect app. This is to help us maintain some semblance of a user session since Atlassian Cloud apps run in an `iframe` that does not natively support cookies.

This is generally handled for you in most areas. However, you may need to manually include a `request_identifier` parameter in request URLs if you are building AJAX requests to your own application. You can get a new request identifier by calling `@app_install.generate_request_identifier`.

### Licensing

We utilize [Atlassian Marketplace's License API for Cloud Apps](https://developer.atlassian.com/platform/marketplace/license-api-for-cloud-apps/). License enforcement is required for paid apps in the Atlassian Marketplace.

To remove all licensing checks, set `Atlassian::Connect.configure.enable_licensing = false`.

To ignore licensing during development, add the following to your project's environment variables:

```
IGNORE_ATLASSIAN_LICENSING=true
```

## Testing
Execute the following to migrate the database and test against the `spec/dummy` app:

```bash
cd spec/dummy
bin/rails db:migrate RAILS_ENV=TEST
cd ../../
rspec
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
