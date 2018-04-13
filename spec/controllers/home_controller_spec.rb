require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    let(:sample_research) { create(:research) }

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "it should have a active_record_list of researches" do
      get :index
      result = Research.all.order('created_at desc')

      expect(assigns(:researches)).to eq(result)
    end
  end
end
