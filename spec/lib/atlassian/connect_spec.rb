require 'rails_helper'

RSpec.describe Atlassian::Connect, type: :engine do
  before(:each) do
    Atlassian::Connect::Configuration.reset
  end

  describe 'defaults' do
    it 'defaults to a valid configuration' do
      Atlassian::Connect.configure do |config|
        # change nothing.
      end
    end
  end

  describe 'key' do
    it 'accepts valid values' do
      Atlassian::Connect.configure do |config|
        config.key = 'valid-key.123'
      end
    end

    it 'rejects invalid values' do
      expect {
        Atlassian::Connect.configure do |config|
          config.key = "YOU CAN'T HAVE SPACES (OR SPECIAL CHARACTERS) IN A KEY!"
        end
      }.to raise_error(ArgumentError)
      expect {
        Atlassian::Connect.configure do |config|
          config.key = "you.can.not.have.an.incredibly.long.key.either--the.limit.is.64.characters."
        end
      }.to raise_error(ArgumentError)
    end
  end

  describe 'api_version' do
    it 'accepts valid values' do
      Atlassian::Connect.configure do |config|
        config.api_version = 1
      end
      Atlassian::Connect.configure do |config|
        config.api_version = 9999
      end
      Atlassian::Connect.configure do |config|
        config.api_version = nil
      end
    end

    it 'rejects invalid values' do
      expect {
        Atlassian::Connect.configure do |config|
          config.api_version = 'only integers allowed'
        end
      }.to raise_error(ArgumentError)
    end
  end
end
