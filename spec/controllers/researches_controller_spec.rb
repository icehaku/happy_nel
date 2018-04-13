require "rails_helper"

RSpec.describe ResearchesController, type: :controller do
  describe "#release_research" do
    let!(:user_1)           { create(:user, email: "1") }
    let!(:user_2)           { create(:user, email: "2") }
    let!(:running_research) { create(:research) }

    it "should not release a research if there is a running one" do
      get :release_research
      result = Research.all.count

      expect(result).to eq(1)
    end
  end

  describe "#release_research" do
    let!(:user_1) { create(:user) }

    it "should not release a research if there isnt at least 2 users" do
      get :release_research
      result = Research.all.count

      expect(result).to eq(0)
    end
  end

  describe "#release_research" do
    let!(:user_1)           { create(:user, email: "1") }
    let!(:user_2)           { create(:user, email: "2") }

    it "should release a research" do
      get :release_research
      result_research = Research.all.count
      result_tokens = ResearchToken.all.count

      expect(result_research).to eq(1)
      expect(result_tokens).to eq(2)
    end
  end

  describe "#force_research_conclusion" do
    let!(:running_research) { create(:research) }

    it "finish the current research" do
      get :force_research_conclusion, params: { id: running_research.id }
      result = Research.find(running_research.id)

      expect(result.concluded).to eq(true)
    end
  end
end
