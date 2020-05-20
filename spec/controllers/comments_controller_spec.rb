require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create :user }
  let(:another_user) { create :user }
  let(:post) { create :post }
  let(:comment) { create :comment }
  before { sign_in user }

  describe '#create' do
    let(:params) do
      {
        post_id: post.id,
        comment: attributes_for(:comment)
      }
    end

    subject{ process :create, params: params }

    it 'create comment' do
      expect { subject }.to change { Comment.count }.by(1)
      is_expected.to redirect_to(post)
    end
  end


  describe '#destroy' do
    let(:params) { { post_id: post.id } }
    let!(:comment){ create :comment, user: user, post: post }
    let(:params){ { id: comment.id, user_id: user.id, post_id: post.id } }

    subject{ process :destroy, method: :delete, params: params }

    it 'destroy comment' do
      expect { subject }.to change { Comment.count }.by(-1)
      is_expected.to redirect_to(request.referrer || root_url)
    end
    context "when user tries delete someone else post" do
      let!(:comment) { create :comment }
      it { expect { subject }.to change { Comment.count }.by(0)  }
    end
  end
end
