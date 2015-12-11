require 'rails_helper'

describe RequlMobileAdminApi do
  let(:access_token) { 'accesstoken' }
  let(:admin) { { 'admin' => { 'id' => 1, 'first_name' => 'first_name', 'last_name' => 'last_name' } } }
  let(:admins) do
    { 'admins' =>
      [
        { 'id' => 1, 'first_name' => 'first_name1', 'last_name' => 'last_name1' },
        { 'id' => 2, 'first_name' => 'first_name2', 'last_name' => 'last_name2' }
      ]
    }
  end

  describe '.admin_info' do
    context 'request admin_id is exist' do
      it 'response has admin' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
                { access_token: access_token, application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
          .and_return(admin)
        ret = RequlMobileAdminApi.new(access_token).admin_info(admin['admin']['id'])
        expect(ret).to eq admin['admin']
      end
    end
    context 'request admin_id is not exist' do
      it 'raise error' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
                { access_token: access_token, application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
          .and_return({})
        expect {
          RequlMobileAdminApi.new(access_token).admin_info(admin['admin']['id'])
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '.admins' do
    context 'request admin_ids is exist' do
      it 'response has admin' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/list",
                { admin_ids: [1, 2], access_token: access_token, application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
          .and_return(admins)
        ret = RequlMobileAdminApi.new(access_token).admins([admins['admins'][0]['id'], admins['admins'][1]['id']])
        expect(ret).to eq admins
      end
    end
  end
end
