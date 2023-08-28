require 'rails_helper'

RSpec.describe "Tables" do
  describe "GET /create" do
    it "returns http success" do
      get "/tables/create"
      expect(response).to have_http_status(:success)
    end
  end

end
