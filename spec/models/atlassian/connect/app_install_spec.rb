require 'rails_helper'

RSpec.describe Atlassian::Connect::AppInstall, type: :model do
  it 'is valid if all attributes are valid' do
    expect(Fabricate(:app_install)).to be_valid
  end

  it 'is invalid without a base_url' do
    expect{Fabricate(:app_install, base_url: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a client_key' do
    expect{Fabricate(:app_install, client_key: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is invalid without a shared_secret' do
    expect{Fabricate(:app_install, shared_secret: nil)}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
