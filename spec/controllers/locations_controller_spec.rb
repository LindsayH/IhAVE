require 'rails_helper'

RSpec.describe LocationsController, :type => :controller do

  # location = FactoryGirl.new :location
  let(:location) { create(:location) }
  let(:user) { create :user } 
  before { sign_in user }

  describe "GET #show" do

    it "returns http success" do
      get :show, id: location.id
      expect(response).to have_http_status(:success)
    end
    
  end

end
