# Atlassian::Connect
Atlassian Connect integration for Ruby on Rails.

This provides the following features:
 - Connect App Descriptor
 - Lifecycle Event Webhooks (enabled, disabled, installed, uninstalled)
 - Tracking of app installs and uninstalls
 - TODO: JWT authentication and token management

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'atlassian-connect'
```

And then execute:
```bash
$ bundle
```

Run the following to upgrade your database so you can track app installs:

```bash
bundle exec rake db:migrate
```

Ensure you have the Rails cache enabled. By default in development, you can toggle caching with the following command:

```bash
rails dev:cache
```  

Add the following to your page layout's `<head>` section:

```ruby
<%= atlassian_connect_scripts %>
```

Add the following to your `config/routes.rb`:

```ruby
mount Atlassian::Connect::Engine, at: '/atlassian'
```

## Configuration

Add a `config/initializers/atlassian_connect.rb` file. You can specify any of the following settings:
```ruby
  config.description = "Copies project settings and issues into new projects."
  config.enable_licensing = true
  config.key = 'com.twinsunsolutions.jira.copy-project'
  config.links = {}
  config.modules = {}
  config.name = 'Copy Projects for Jira Cloud'
  config.scopes << 'admin'
  config.vendor_name = 'Twin Sun, LLC'
  config.vendor_url = 'https://twinsunsolutions.com'
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
