require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "it should have a active_record_list of users" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "it should have a instance of user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    let(:sample_user) { build(:user) }

    it "should assign create and save a instance of submitted search" do
      post :create, params: { user: sample_user.attributes }

      result = User.find_by_name(sample_user.name)
      expect(result.present?).to eq true
    end
  end

  describe "#destroy" do
    let!(:user_to_destroy) { create(:user) }

    it "should destroy the referent user by id" do
      post :destroy, params: { id: user_to_destroy.id }

      result = User.all.count
      expect(result).to eq 0
    end
  end

end
