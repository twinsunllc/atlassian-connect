require 'rails_helper'

RSpec.describe Atlassian::Connect::AppDescriptorController, type: :controller do
  render_views

  before(:each) {
    Atlassian::Connect::Configuration.reset
    @routes = Atlassian::Connect::Engine.routes
  }

  let(:valid_session) { { } }

  describe 'GET #index' do
    context 'with valid params' do
      it 'successfully retrieves a valid app descriptor' do
        get :index, params: {}, session: valid_session, format: :json
        expect(response).to be_successful

        manifest = JSON.parse(response.body)
        config = Atlassian::Connect.configuration
        expect(manifest['apiVersion']).to eq(config.api_version)
        expect(manifest['authentication']['type']).to eq('jwt')
        expect(manifest['baseUrl'].present?).to eq(true)
        expect(manifest['enableLicensing']).to eq(config.enable_licensing)
        expect(manifest['key']).to eq(config.key)
      end
    end
  end

end
