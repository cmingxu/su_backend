require 'rails_helper'

RSpec.describe Dashboard::BaseController, type: :controller do

  describe "GET #index without signin" do
    it "should redirect to signin path" do
      get :index
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET #index when signin" do
    before :each do
      @user = create :user
      sign_in :user, @user
    end

    it "should return 200" do
      get :index
      expect(response).to be_success
    end

    it 'should assgn folders with current_user folders' do
      @folder = subject.current_user.folders.create attributes_for(:folder)
      get :index
      expect(assigns(:folders)).to eq([@folder])
    end
  end

end
