require "rails_helper"

RSpec.describe Research, type: :model do
  describe "Should Respond" do
    it { should respond_to :concluded }
  end

  describe "Associations" do
    it { should have_many(:research_token) }
  end

  context "Methods" do
    let!(:research)               { create(:research) }
    let!(:research_not_concluded) { create(:research) }
    let!(:research_token_1)       { create(:research_token, research: research, token: "1") }
    let!(:research_token_2)       { create(:research_token, research: research, token: "2") }

    it "#get_result" do
      grade_total = research.research_token.sum(:grade)
      grade_total = 0 unless grade_total > 0
      expect_result = grade_total / research.research_token.count

      expect(research.get_result).to eq(expect_result)
    end

    it "#get_votes" do
      pending_votes = research.research_token.where.not(grade: nil).count.to_s
      total_votes = research.research_token.count.to_s

      expect(research.get_votes).to eq(pending_votes+"/"+total_votes)
    end

    it "#finish" do
      research_not_concluded.finish
      expect(research_not_concluded.concluded).to eq(true)
    end
  end

  describe "Factory" do
    it { expect(build :research).to be_a Research }
    it { expect(build :research).to be_valid }
  end
end
