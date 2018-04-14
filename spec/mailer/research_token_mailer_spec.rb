require "rails_helper"

RSpec.describe ResearchTokenMailer, :type => :mailer do
  describe "research_email" do
    url = Faker::Internet.url
    let(:user) { build(:user) }
    let(:mail) { ResearchTokenMailer.research_email(user, url) }

    it "renders the headers" do
      expect(mail.subject).to eq("Happy Nel Quality Research")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["elano.garcez.dev@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Happy Nel Quality Research")
    end
  end

  describe "research_concluded_email" do
    grade = "7"
    let(:user) { build(:user) }
    let(:mail) { ResearchTokenMailer.research_concluded_email(user, grade) }

    it "renders the headers" do
      expect(mail.subject).to eq("Happy Nel Quality Research Concluded")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["elano.garcez.dev@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Happy Nel Quality Research Concluded")
    end
  end
end
