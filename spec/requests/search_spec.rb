require 'rails_helper'

RSpec.describe "Searches" do
  describe "GET /index" do
    it "returns http success" do
      get "/search/index"
      expect(response).to have_http_status(:success)
    end
  end

end
