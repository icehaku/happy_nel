require "rails_helper"

RSpec.describe User, type: :model do
  describe "Should Respond" do
    it { should respond_to :name }
    it { should respond_to :email }
  end

  context "Validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe "Factory" do
    it { expect(build :user).to be_a User }
    it { expect(build :user).to be_valid }
  end
end
