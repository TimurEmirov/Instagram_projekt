require 'rails_helper'

RSpec.describe Relationship, type: :model do

  it { is_expected.to belong_to(:follower) }
  it { is_expected.to belong_to(:followed) }

  it { is_expected.to validate_presence_of(:follower_id) }
  it { is_expected.to validate_presence_of(:followed_id) }

  context 'validates relationship' do
    it 'relationship should be valid' do
      michael = create(:user)
      archer = create(:user)
      subject.follower = michael
      subject.followed = archer
      is_expected.to be_valid
    end

    it "should require a follower" do
      subject.follower = nil
      is_expected.to be_invalid
    end

    it "should require a follower" do
      subject.followed = nil
      is_expected.to be_invalid
    end
  end

end
