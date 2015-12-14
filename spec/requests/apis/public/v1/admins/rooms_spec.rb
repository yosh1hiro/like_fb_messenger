require 'spec_helper'

describe Public::V1::Admins::Rooms, type: :request do
  let(:access_token) { 'accesstoken' }
  let(:admin) { { 'admin' => { 'id' => 1, 'first_name' => 'first_name', 'last_name' => 'last_name' } } }
  let(:users) do
    { 'users' => [{ 'id' => 1, 'first_name' => 'first_name1', 'last_name' => 'last_name1' }] }
  end
  describe 'POST /' do
    let(:url) { '/v1/admins/rooms' }
    let(:params) { { user_id: users['users'][0]['id'], admin_id: admin['admin']['id'], access_token: access_token } }
    before do
      allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
        .with(:get,
              "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
              { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
        .and_return(admin)
    end
    context 'returns user and admin from requl_mobile' do
      before do
        allow(RequlMobileUsersApi).to receive(:users).with([users['users'][0]['id']])
          .and_return(users)
        post url, params
      end
      it { expect(response.status).to eq 201 }
      it { expect(json['chat_room']['user_id']).to eq users['users'][0]['id'] }
      it { expect(json['chat_room']['admin_id']).to eq admin['admin']['id'] }
    end
    context 'not return user from requl_mobile' do
      before do
        allow(RequlMobileUsersApi).to receive(:users).with([users['users'][0]['id']])
          .and_return({})
        post url, params
      end
      it { expect(response.status).to eq 400 }
    end
  end
end
