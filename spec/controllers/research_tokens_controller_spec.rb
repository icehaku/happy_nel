require "rails_helper"

RSpec.describe ResearchTokensController, type: :controller do
  let!(:sample_research_token) { create(:research_token) }

  describe "#cast_vote" do
    it "renders the cast_vote template" do
      get :cast_vote, params: { token: sample_research_token.token }
      expect(response).to render_template(:cast_vote)
    end

    it "has a 200 status code" do
      get :cast_vote, params: { token: sample_research_token.token }
      expect(response.status).to eq(200)
    end
  end

  describe "#save_vote" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "renders the cast_vote template" do
      get :save_vote, params: { research_token_grade: "7",
                                research_token: sample_research_token.attributes }

      result = ResearchToken.find_by_token(sample_research_token.token)

      expect(result.grade).to eq(7)
    end
  end
end
