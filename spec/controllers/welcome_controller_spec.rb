require "spec_helper"

describe WelcomeController do
  describe "services" do
    it "should responde index" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end
end
