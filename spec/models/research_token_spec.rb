require "rails_helper"

RSpec.describe ResearchToken, type: :model do
  describe "Should Respond" do
    it { should respond_to :token }
    it { should respond_to :grade }
    it { should respond_to :research }
  end

  describe "Associations" do
    it { should belong_to(:research) }
  end

  describe "Callbacks" do
    it { is_expected.to callback(:send_result_if_research_concluded).after(:save) }
  end

  describe "Methods" do
    let!(:research_concluded)         { create(:research) }
    let!(:research_token_concluded_1) { create(:research_token, research: research_concluded, token: "1") }
    let!(:research_token_concluded_2) { create(:research_token, research: research_concluded, token: "2") }

    let!(:research_not_concluded)         { create(:research) }
    let!(:research_token_not_concluded_1) { create(:research_token, :without_grade, research: research_not_concluded, token: "4") }
    let!(:research_token_not_concluded_2) { create(:research_token, research: research_not_concluded, token: "3") }

    it "#should send_result_if_research_concluded" do
      expect(research_concluded.concluded).to eq(true)
    end

    it "#should NOT send_result_if_research_concluded is FALSE" do
      expect(research_not_concluded.concluded).to eq(false)
    end
  end

  describe "Factory" do
    it { expect(build :research_token).to be_a ResearchToken }
    it { expect(build :research_token).to be_valid }
  end
end
