require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  describe "GET #index" do

  	let(:location) { create :location }
  	# before {sign_in user}
    it "returns http success" do
      get :index, location_id: location.id
      expect(response).to have_http_status(:success)
    end
  end

end
