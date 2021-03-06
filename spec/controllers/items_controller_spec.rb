require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do

  let(:user) { create :user }
  let(:location) { create(:location, user: user) }
  let(:item) { create :item, user: user}
  before { sign_in user }

  describe "post#create" do

      context 'item is not valid' do
       subject {post :create, location_id: location.id, item: { name: '' }}
        it 'renders the new page' do
          expect { subject }.to_not change(Item, :count)
          expect(response).to render_template(:new)
        end
      end

      context 'item is valid ' do
        subject {post :create, location_id: location.id, item: { name: 'name', description: 'hi I am a test' } }

        it 'renders the  location' do
          expect{ subject }.to change(Location, :count).by(1)
          expect(response).to have_http_status(302)
        end
      end

  end

  describe "patch#update" do

    context 'Item update is valid' do
      subject {}
      it 'redirects to the location show page' do
        params = {id: item.id, location_id: location.id, item: { name: "name", description: 'hi I am a test' } }

        expect(
          put :update, params
        ).to have_http_status(302)
      end

    end
      context 'Item update is invalid' do
        subject {patch :update, id: item.id, location_id: location.id, item: { name: nil, description: 'hi I am a test' }}
        it "sould render the new template" do 
          expect(subject).to have_http_status(:redirect)
        end

    end


  end


  describe "GET #index" do
    subject {get :index, location_id: location.id }

    it "returns http success" do
      expect(subject).to have_http_status(:success)
    end

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: item.id, location_id: location.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "item#new"do

    it "displays the new page" do
      get :new, {location_id: location.id}
      expect(response).to render_template(:new)
    end
  end

  describe "item#destroy"do
    it "redirects to the locations show" do
      delete :destroy, {id: item.id, location_id: location.id}
      expect(response).to have_http_status(:redirect)
    end

    it "changes the item count by -1" do
      item
      count = Item.count
      delete :destroy, {id: item.id, location_id: location.id}
      expect(Item.count).to eql(count-1)
    end
  end
   describe "item can have taggs" do
      it "will sort items by tags" do 
        
        get :tag, location_id: item.location_id, item_id: item.id, tag: "test" 
        expect(@item.first.tag_list).to eql("test")
      end
   end

end
