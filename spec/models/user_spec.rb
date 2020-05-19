require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:likeposts) }

  it { is_expected.to have_many(:passive_relationships).with_foreign_key(:followed_id).class_name('Relationship') }
  it { is_expected.to have_many(:followers).through(:passive_relationships).source(:follower) }

  it { is_expected.to have_many(:active_relationships).with_foreign_key(:follower_id).class_name('Relationship') }
  it { is_expected.to have_many(:following).through(:active_relationships).source(:followed) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }

  context 'validates image format' do
    it 'allows to set png file as an avatar' do
      user = create(:user)
      is_expected.to be_valid
    end

    # it 'not allows to set txt file as an avatar' do
    #   user = create(:user, :with_invalid_avatar)
    #   is_expected.to be_invalid
    # end
  end
end
