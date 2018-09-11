require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context "assigns" do
      let!(:status) { create :status }
      let!(:status_message) { create :status_message }

      it "current_status data" do
        get :index
        expect(assigns(:current_status).id).to equal(status.id)
      end

      it "status_messages data" do
        get :index
        expect(assigns(:status_messages).first.id).to equal(status_message.id)
      end
    end
  end
end
