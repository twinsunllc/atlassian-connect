require 'rails_helper'

RSpec.describe Atlassian::Connect::LifecycleController, type: :controller do
  before(:each) {
    @routes = Atlassian::Connect::Engine.routes
  }

  let(:valid_session) { {} }

  describe 'POST #disabled' do

    context 'with valid params' do
      it 'successfully completes a disablement' do
        disabled_payload = JSON.parse(file_fixture('lifecycle/disabled.json').read)
        post :disabled, params: disabled_payload, session: valid_session
        expect(response).to be_successful
      end
    end

  end

  describe 'POST #enabled' do

    context 'with valid params' do
      it 'successfully completes an enablement' do
        enabled_payload = JSON.parse(file_fixture('lifecycle/enabled.json').read)
        post :enabled, params: enabled_payload, session: valid_session
        expect(response).to be_successful
      end
    end

  end

  describe 'POST #installed' do

    context 'with valid params' do
      it 'successfully completes a new install' do
        installed_payload = JSON.parse(file_fixture('lifecycle/installed.json').read)
        expect {
          post :installed, params: installed_payload, session: valid_session
        }.to change{Atlassian::Connect::AppInstall.count}.by(1)
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'fails to complete installation when no JWT secret is provided' do
        installed_invalid_payload = JSON.parse(file_fixture('lifecycle/installed-invalid.json').read)
        post :installed, params: installed_invalid_payload, session: valid_session
        expect(response.status).to eq(400)
      end
    end

  end

  describe 'POST #uninstalled' do

    context 'with valid params' do
      it 'successfully completes a new install' do
        app_install = Fabricate(:app_install)
        expect(app_install.uninstalled_at).to eq(nil)

        uninstalled_payload = JSON.parse(file_fixture('lifecycle/uninstalled.json').read)
        post :uninstalled, params: uninstalled_payload, session: valid_session
        expect(response).to be_successful

        app_install.reload
        expect(app_install.uninstalled_at).not_to eq(nil)
      end
    end

    context 'with invalid params' do
      it 'responds successfully even if there is nothing to uninstall' do
        uninstalled_invalid_payload = JSON.parse(file_fixture('lifecycle/uninstalled-invalid.json').read)
        post :uninstalled, params: uninstalled_invalid_payload, session: valid_session
        expect(response).to be_successful
      end
    end
  end

end
