require 'rails_helper'

RSpec.describe "Admins" do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/index"
      expect(response).to have_http_status(:success)
    end
  end

end
