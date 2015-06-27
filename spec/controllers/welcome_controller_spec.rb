require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET #index" do
    it 'should response with 200' do
      get :index
      expect(response).to be_success
    end

    it 'should render template' do
      get :index
      expect(response).to render_template("index")
    end
  end
end
