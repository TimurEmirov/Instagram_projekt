require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_one) { create :user }
  let!(:user_two) { create :user }

  describe "#index" do
    subject { get :index }

    it 'should redirect when not logged in' do
      subject
      is_expected.to redirect_to('/users/sign_in')
    end

    it 'show users' do
      sign_in user_one
      subject
      expect(assigns(:users).map(&:id).count).to eq(User.count)
      is_expected.to render_template('index')
    end
  end


  describe "#show" do
    let(:params) { { id: user_one.id } }
    subject { get :show, params: params }
    let!(:post){ create :post, user: user_one }

    it 'should redirect when not logged in' do
      subject
      is_expected.to redirect_to('/users/sign_in')
    end

    it 'show users' do
      sign_in user_one
      subject
      expect(assigns(:posts).map(&:id).count).to eq(Post.count)
      is_expected.to render_template('show')
    end
  end


  describe "#following" do
    let(:params) { { id: user_one.id } }
    subject{ get :following, params: params }

    it 'should redirect when not logged in' do
      subject
      is_expected.to redirect_to('/users/sign_in')
    end

    it 'show following users' do
      sign_in user_one
      user_one.follow(user_two)
      subject
      expect(assigns(:users).map(&:id).count).to eq(user_one.following.count)
      is_expected.to render_template("users/show_follow")
    end

    describe "#followers" do
      let(:params) { { id: user_one.id } }
      subject{ get :followers, params: params }

      it 'should redirect when not logged in' do
        subject
        is_expected.to redirect_to('/users/sign_in')
      end

      it 'show followers users' do
        sign_in user_one
        user_two.follow(user_one)
        subject
        expect(assigns(:users).map(&:id).count).to eq(user_one.followers.count)
        is_expected.to render_template("users/show_follow")
      end
    end
  end
end
