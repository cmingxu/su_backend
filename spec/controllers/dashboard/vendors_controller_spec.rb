require 'rails_helper'

RSpec.describe Dashboard::VendorsController, type: :controller do
  before do
    @user = create :user
    @user.roles = ["admin"]
    @user.save
    sign_in :user, @user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new "do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'should create vendor with valid attributes' do
      post_proc = Proc.new do
        post :create, vendor: attributes_for(:vendor)
      end

      expect(post_proc).to change(Vendor, :count).by(1)
    end
  end

  describe "GET #edit "do
    it "returns http success" do
      @vendor = create :vendor
      get :edit, id: @vendor.id
      expect(response).to have_http_status(:success)
      expect(assigns[:vendor]).to eq(@vendor)
    end
  end

end
