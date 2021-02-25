# Atlassian::Connect
Atlassian Connect integration for Ruby on Rails.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'atlassian-connect'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install atlassian-connect
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
