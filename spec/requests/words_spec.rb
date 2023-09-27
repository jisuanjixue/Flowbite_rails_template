require 'rails_helper'

RSpec.describe "Words" do
  describe "GET /create" do
    it "returns http success" do
      get "/words/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/words/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
