require 'spec_helper'

describe Public::V1::Admins, type: :request do
  let(:access_token) { 'accesstoken' }
  let(:admin) { { email: 'text@example.com', password: 'password' } }
  describe 'POST #sign_in' do
    let(:url) { '/v1/admins/sign_in' }
    let(:params) { { email: admin[:email], password: admin[:password] } }
    before do
      allow(RequlMobileAdminApi).to receive(:access_token).with(admin[:email], admin[:password])
        .and_return(access_token)
      post url, params
    end
    it { expect(response.status).to eq 201 }
    it { expect(json['access_token']).to eq access_token }
  end
end
