require 'rails_helper'

describe RequlMobileAdminApi do
  let(:admin) { { 'admin' => { 'id' => 1, 'first_name' => 'first_name', 'last_name' => 'last_name' } } }

  describe '.admin_info' do
    context 'request admin_id is exist' do
      it 'response has admin' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
                { application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
          .and_return(admin)
        ret = RequlMobileAdminApi.new.admin_info(admin['admin']['id'])
        expect(ret).to eq admin['admin']
      end
    end
    context 'request admin_id is not exist' do
      it 'raise error' do
        allow_any_instance_of(RequlMobileAdminApi).to receive(:request)
          .with(:get,
                "#{RequlMobileAdminApi::INTERNAL_BASE_URL}/v1/admins/#{admin['admin']['id']}",
                { application_token: RequlMobileAdminApi::APPLICATION_TOKEN })
          .and_return({})
        expect {
          RequlMobileAdminApi.new.admin_info(admin['admin']['id'])
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
