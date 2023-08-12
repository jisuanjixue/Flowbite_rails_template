require 'rails_helper'

RSpec.describe "Posts" do
  describe "GET /index" do
    it "returns http success" do
      get "/posts/index"
      expect(response).to have_http_status(:success)
    end
  end

end
