require 'spec_helper'

describe Public::V1::Admins::Posts, type: :request do
  let(:access_token) { 'accesstoken' }
  let(:admin) do
    { 'admin' =>
      {
        'id' => 1,
        'first_name' => 'first_name',
        'last_name' => 'last_name',
        'name' => 'last_name first_name',
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
  let(:chat_room) do
    chat_room = create(:chat_direct_with_admin_room, admin_id: admin['admin']['id'], user_id: users['users'][0]['id'])
    chat_room.cache!(name: "#{users['users'][0]['name']} / #{admin['admin']['name']}")
    chat_room
  end

  describe 'POST /' do
    let(:url) { '/v1/admins/posts' }
    before do
      allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
        .with(:get,
              "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/me",
              { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
        .and_return(admin)
    end
    context 'content_type is message' do
      let(:params) { { content_type: 'message', room_id: chat_room.id, message: message, access_token: access_token } }
      context 'message is present' do
        let(:message) { 'chat message' }
        it 'returns status code 200' do
          post url, params
          expect(response.status).to eq 201
        end
        it 'creates ChatDirectWithAdminFromAdminMessage record' do
          expect {
            post url, params
          }.to change(ChatDirectWithAdminFromAdminMessage, :count).by(1)
          post = ChatDirectWithAdminFromAdminMessage.find_by(chat_direct_with_admin_room: chat_room)
          expect(post).to be_truthy
          expect(post.message).to eq message
        end
        it 'creates ChatPostCache record' do
          expect {
            post url, params
          }.to change(ChatPostCache, :count).by(1)
          post_cache = ChatPostCache.find_by(chat_room: chat_room, sender_id: admin['admin']['id'], sender_type: 'Admin')
          post = ChatDirectWithAdminFromAdminMessage.find_by(chat_direct_with_admin_room: chat_room)
          expect(post_cache).to be_truthy
          expect(post_cache.message).to eq post.message
          expect(post_cache.posted_at).to eq post.created_at
        end
        it 'updates ChatRoomIndexCache record' do
          post url, params
          room_cache = ChatRoomIndexCache.find_by(chat_room: chat_room)
          post = ChatDirectWithAdminFromAdminMessage.find_by(chat_direct_with_admin_room: chat_room)
          expect(room_cache.last_sent_message).to eq post.message
          expect(room_cache.last_sent_at).to eq post.created_at
        end
        it 'returns json response' do
          post url, params
          expect(json['chat_post']['postable_type']).to eq 'ChatDirectWithAdminFromAdminMessage'
          expect(json['chat_post']['message']).to eq message
          expect(json['chat_post']['chat_room_id']).to eq chat_room.id
          expect(json['chat_post']['sender']['id']).to eq admin['admin']['id']
          expect(json['chat_post']['sender']['last_name']).to eq admin['admin']['last_name']
          expect(json['chat_post']['sender']['first_name']).to eq admin['admin']['first_name']
          expect(json['chat_post']['sender']['type']).to eq 'Admin'
        end
      end
      context 'message is blank' do
        let(:message) { '' }
        before do
          post url, params
        end
        it { expect(response.status).to eq 400 }
      end
    end
  end
end
