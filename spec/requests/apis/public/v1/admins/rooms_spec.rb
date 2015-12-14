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
      end
      it 'returns status code 200' do
        post url, params
        expect(response.status).to eq 201
      end
      it 'creates ChatDirectWithAdminRoom record' do
        expect {
          post url, params
        }.to change(ChatDirectWithAdminRoom, :count).by(1)
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin['admin']['id'])
        expect(room).to be_truthy
      end
      it 'creates ChatRoomIndexCache record' do
        expect {
          post url, params
        }.to change(ChatRoomIndexCache, :count).by(1)
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin['admin']['id'])
        expect(room.chat_room_index_cache).to be_truthy
      end
      it 'returns json response' do
        post url, params
        expect(json['chat_room']['user_id']).to eq users['users'][0]['id']
        expect(json['chat_room']['admin_id']).to eq admin['admin']['id']
      end
    end
    context 'not return user from requl_mobile' do
      before do
        allow(RequlMobileUsersApi).to receive(:users).with([users['users'][0]['id']])
          .and_return({})
      end
      it 'returns status code 400' do
        post url, params
        expect(response.status).to eq 400
      end
      it 'creates ChatDirectWithAdminRoom record' do
        expect {
          post url, params
        }.not_to change(ChatDirectWithAdminRoom, :count)
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin['admin']['id'])
        expect(room).to be nil
      end
    end
  end
end
