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

  describe '.me' do
    before do
      allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
        .with(:get,
              "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/me",
              { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
        .and_return(admin)
    end
    subject(:member) { FiChat::Member::Admin.me(access_token) }
    it { should be_instance_of(FiChat::Member::Admin) }
    it { expect(member.id).to eq admin['admin']['id'] }
    it { expect(member.first_name).to eq admin['admin']['first_name'] }
    it { expect(member.last_name).to eq admin['admin']['last_name'] }
  end

  describe '.find' do
    before do
      allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
        .with(:get,
              "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
              { access_token: access_token, application_token: RequlMobileAdminsApi::APPLICATION_TOKEN })
        .and_return(admin)
    end
    subject(:member) { FiChat::Member::Admin.find(admin['admin']['id'], access_token) }
    it { should be_instance_of(FiChat::Member::Admin) }
    it { expect(member.id).to eq admin['admin']['id'] }
    it { expect(member.first_name).to eq admin['admin']['first_name'] }
    it { expect(member.last_name).to eq admin['admin']['last_name'] }
  end

  describe '.find_list' do
    context 'request admin_ids are exist' do
      subject(:members) { FiChat::Member::Admin.find_list([admins['admins'][0]['id'], admins['admins'][1]['id']], access_token) }
      before do
        allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/list",
                {
                  admin_ids: [admins['admins'][0]['id'], admins['admins'][1]['id']],
                  access_token: access_token,
                  application_token: RequlMobileAdminsApi::APPLICATION_TOKEN
                })
          .and_return(admins)
      end
      it { should be_instance_of(Array) }
      it { expect(members.size).to eq 2 }
      it { expect(members[0]).to be_instance_of(FiChat::Member::Admin) }
      it { expect(members[0].id).to eq admins['admins'][0]['id'] }
      it { expect(members[0].first_name).to eq admins['admins'][0]['first_name'] }
      it { expect(members[0].last_name).to eq admins['admins'][0]['last_name'] }
      it { expect(members[1]).to be_instance_of(FiChat::Member::Admin) }
      it { expect(members[1].id).to eq admins['admins'][1]['id'] }
      it { expect(members[1].first_name).to eq admins['admins'][1]['first_name'] }
      it { expect(members[1].last_name).to eq admins['admins'][1]['last_name'] }
    end
    context 'request admin_id are not exist neither' do
      before do
        allow_any_instance_of(RequlMobileAdminsApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminsApi::INTERNAL_BASE_URL}/v1/admins/list",
                {
                  admin_ids: [admins['admins'][0]['id'], admins['admins'][1]['id']],
                  access_token: access_token,
                  application_token: RequlMobileAdminsApi::APPLICATION_TOKEN
                })
          .and_return({ 'admins' => [] })
      end
      it 'raise error' do
        expect {
          FiChat::Member::Admin.find_list([admins['admins'][0]['id'], admins['admins'][1]['id']], access_token)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
