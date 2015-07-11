require 'rails_helper'

RSpec.describe Dashboard::EntitiesController, type: :controller do

  describe "inhrited from dashboard base" do
    it 'should be subclass of Dashboard::BaseController' do
      expect(Dashboard::EntitiesController.superclass).to be(Dashboard::BaseController)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
