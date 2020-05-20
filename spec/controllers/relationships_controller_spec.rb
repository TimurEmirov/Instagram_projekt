require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user_one) { create :user }
  let(:user_two) { create :user }
  before { sign_in user_one }


  describe "#create" do
    let(:params) { { followed_id: user_two.id } }
    subject{ post :create, params: params }
    it 'following' do
      expect { subject }.to change { Relationship.count }.by(1)
    end
  end

  describe '#destroy' do
    let!(:relationship){ post :create, params: { followed_id: user_two.id } }
    let(:params){ { id: Relationship.first.id } }
    subject{ process :destroy, method: :delete, params: params }
    it 'unfollowing' do
      expect { subject }.to change { Relationship.count }.by(-1)
    end
  end

end
