require 'rails_helper'

describe FiChat::Member::Admin do
  let(:access_token) { 'accesstoken' }
  let(:admin) { { 'admin' => { 'id' => 1, 'first_name' => 'first_name', 'last_name' => 'last_name' } } }
  let(:admins) do
    {
      'admins' => [
        { 'id' => 1, 'first_name' => 'first_name1', 'last_name' => 'last_name1' },
        { 'id' => 2, 'first_name' => 'first_name2', 'last_name' => 'last_name2' }
      ]
    }
  end

  describe '.find' do
    it 'admin instance is created' do
      allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
        .with(:get,
              "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
              { access_token: access_token, application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
        .and_return(admin)
      member = FiChat::Member::Admin.find(admin['admin']['id'], access_token)
      expect(member).to be_instance_of(FiChat::Member::Admin)
      expect(member.id).to eq admin['admin']['id']
      expect(member.first_name).to eq admin['admin']['first_name']
      expect(member.last_name).to eq admin['admin']['last_name']
    end
  end

  describe '.find_list' do
    context 'request admin_ids are exist' do
      it 'admin instances are created' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/list",
                {
                  admin_ids: [admins['admins'][0]['id'], admins['admins'][1]['id']],
                  access_token: access_token,
                  application_token: RequlMobileAdminApi::APPLICATION_TOKEN
                })
          .and_return(admins)
        members = FiChat::Member::Admin.find_list([admins['admins'][0]['id'], admins['admins'][1]['id']], access_token)
        expect(members).to be_instance_of(Array)
        expect(members.size).to eq 2
        expect(members[0]).to be_instance_of(FiChat::Member::Admin)
        expect(members[0].id).to eq admins['admins'][0]['id']
        expect(members[0].first_name).to eq admins['admins'][0]['first_name']
        expect(members[0].last_name).to eq admins['admins'][0]['last_name']
        expect(members[1]).to be_instance_of(FiChat::Member::Admin)
        expect(members[1].id).to eq admins['admins'][1]['id']
        expect(members[1].first_name).to eq admins['admins'][1]['first_name']
        expect(members[1].last_name).to eq admins['admins'][1]['last_name']
      end
    end
    context 'request admin_id are not exist neither' do
      it 'admin instance are not created' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/list",
                {
                  admin_ids: [admins['admins'][0]['id'], admins['admins'][1]['id']],
                  access_token: access_token,
                  application_token: RequlMobileAdminApi::APPLICATION_TOKEN
                })
          .and_return({ 'admins' => [] })
        members = FiChat::Member::Admin.find_list([admins['admins'][0]['id'], admins['admins'][1]['id']], access_token)
        expect(members).to be_instance_of(Array)
        expect(members.size).to eq 0
      end
    end
  end
end
