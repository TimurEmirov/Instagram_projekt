require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { create :user }
  let(:params) { { user_id: user } }

  before { sign_in user }

  describe '#show' do
    let(:params) { { user_id: user.id, id: post } }
    subject{ get :show, params: params }
    let!(:post){ create :post, user: user }
    it 'assign @post' do
      subject
      expect(assigns(:post)).to eq(post)
    end
    it {is_expected.to render_template(:show)}
  end

  describe '#create' do
    let(:params) do
      {
        post: attributes_for(:post, :with_valid_image)
      }
    end
    subject{ post :create, params: params }
    it 'create post' do
      expect { subject }.to change { Post.count }.by(1)
      is_expected.to redirect_to(post_path(assigns(:post)))
    end
  end

  describe '#destroy' do
    let!(:post){ create :post, user: user }
    let(:params){ { id: post, user_id: user } }
    subject{ process :destroy, method: :delete, params: params }
    it 'destroy post' do
      expect { subject }.to change { Post.count }.by(-1)
      is_expected.to redirect_to(request.referrer || root_url)
    end
    context "when user tries delete someone else post" do
      let!(:post) { create :post }
      it { expect { subject }.to change { Post.count }.by(0)  }
    end

  end



end
