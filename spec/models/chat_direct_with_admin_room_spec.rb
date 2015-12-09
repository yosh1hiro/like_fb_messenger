# == Schema Information
#
# Table name: chat_direct_with_admin_rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  admin_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_chat_direct_with_admin_rooms_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe ChatDirectWithAdminRoom, type: :model do
  describe '.find_or_create_by' do
    let(:user_params1) do
      {
        'id' => 1,
        'last_name' => 'Ritenour',
        'first_name' => 'Lee',
        'access_token' => 'user'
      }
    end
    let(:user1) { FiChat::Member::User.new(user_params1) }
    let(:admin_params1) do
      {
        'id' => 1,
        'last_name' => 'Carlton',
        'first_name' => 'Larry',
        'access_token' => 'admin'
      }
    end
    let(:admin1) { FiChat::Member::Admin.new(admin_params1) }
    let(:subject_method){ ChatDirectWithAdminRoom.find_or_create_by(user1, admin1) }
    it { expect(subject_method).to be_kind_of(ChatDirectWithAdminRoom) }
    context 'Room does not exist' do
      it 'stores a new room' do
        expect { subject_method }.to change(ChatDirectWithAdminRoom, :count).by(1)
      end
    end

    context 'Room already exists' do
      let!(:chat_room) { ChatDirectWithAdminRoom.create(user_id: user1.id, admin_id: admin1.id) }
      it 'does not store a new room' do
        expect {  subject_method }.to change(ChatDirectWithAdminRoom, :count).by(0)
      end
    end
  end
end
