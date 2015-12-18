require 'spec_helper'

describe Public::V1::Admins::Rooms, type: :request do
  let(:access_token) { 'accesstoken' }
  let(:admin1) do
    { 'admin' =>
      {
        'id' => 1,
        'first_name' => 'first_name1',
        'last_name' => 'last_name1',
        'name' => 'last_name1 first_name1',
        'access_token' => access_token
      }
    }
  end
  let(:admin2) do
    { 'admin' =>
      {
        'id' => 2,
        'first_name' => 'first_name2',
        'last_name' => 'last_name2',
        'name' => 'last_name2 first_name2',
        'access_token' => access_token
      }
    }
  end
  let(:users) do
    { 'users' =>
      [
        {
          'id' => 1,
          'first_name' => 'first_name1',
          'last_name' => 'last_name1',
          'name' => 'last_name1 first_name1'
        }
      ]
    }
  end
  let(:admin_id) { admin['admin']['id'] }
  let(:chat_room) do
    chat_room = create(:chat_direct_with_admin_room, admin_id: admin['admin']['id'], user_id: users['users'][0]['id'])
    chat_room.cache!(name: "#{users['users'][0]['name']} / #{admin['admin']['name']}")
    chat_room
  end
  let(:chat_message_from_admin) do
    sender = ::FiChat::Member::Admin.new(admin['admin'])
    chat_message = create(:chat_direct_with_admin_from_admin_message, sender: sender, chat_direct_with_admin_room: chat_room)
    chat_message.save_with_cache!
    chat_message
  end

  before do
    allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
      .with(:get,
            "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/me",
            { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
      .and_return(admin1)
  end

  describe 'GET /:admin_id/rooms' do
    let(:admin) { admin2 }
    let(:url) { "/v1/admins/#{admin_id}/rooms" }
    let(:params) { { access_token: access_token } }
    before do
      chat_message_from_admin
    end
    context 'returns admin from requl_mobile' do
      before do
        allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/#{admin_id}",
                { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
          .and_return(admin)
        get url, params
      end
      it { expect(response.status).to eq 200 }
      it { expect(json['chat_rooms'][0]['chat_room_id']).to eq chat_room.id }
      it { expect(json['chat_rooms'][0]['chat_room_type']).to eq 'ChatDirectWithAdminRoom' }
      it { expect(json['chat_rooms'][0]['target_type']).to eq 'Admin' }
      it { expect(json['chat_rooms'][0]['last_sent_message']).to eq chat_message_from_admin.message }
    end
    context 'not return admin from requl_mobile' do
      before do
        allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/#{admin_id}",
                { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
          .and_return({})
        get url, params
      end
      it { expect(response.status).to eq 404 }
    end
  end

  describe 'GET /rooms/mine' do
    let(:admin) { admin1 }
    let(:url) { '/v1/admins/rooms/mine' }
    let(:params) { { access_token: access_token } }
    context 'returns admin from requl_mobile' do
      before do
        chat_message_from_admin
        get url, params
      end
      it { expect(response.status).to eq 200 }
      it { expect(json['chat_rooms'][0]['chat_room_id']).to eq chat_room.id }
      it { expect(json['chat_rooms'][0]['chat_room_type']).to eq 'ChatDirectWithAdminRoom' }
      it { expect(json['chat_rooms'][0]['target_type']).to eq 'Admin' }
      it { expect(json['chat_rooms'][0]['last_sent_message']).to eq chat_message_from_admin.message }
    end
    context 'not return admin from requl_mobile' do
      before do
        allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/me",
                { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
          .and_return({})
        get url, params
      end
      it { expect(response.status).to eq 404 }
    end
  end

  describe 'POST /' do
    let(:admin) { admin1 }
    let(:url) { '/v1/admins/rooms' }
    let(:params) { { user_id: users['users'][0]['id'], admin_id: admin_id, access_token: access_token } }
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
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin_id)
        expect(room).to be_truthy
      end
      it 'creates ChatRoomIndexCache record' do
        expect {
          post url, params
        }.to change(ChatRoomIndexCache, :count).by(1)
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin_id)
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
        room = ChatDirectWithAdminRoom.find_by(user_id: users['users'][0]['id'], admin_id: admin_id)
        expect(room).to be nil
      end
    end
  end
end
