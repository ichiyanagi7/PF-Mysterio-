require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/users/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/users/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/users/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /unsubscribe" do
    it "returns http success" do
      get "/users/unsubscribe"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /withdraw" do
    it "returns http success" do
      get "/users/withdraw"
      expect(response).to have_http_status(:success)
    end
  end

end
