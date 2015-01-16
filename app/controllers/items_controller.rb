class ItemsController < ApplicationController
  
  def show
    @items =  Item.find_by(user_id: current_user)
  end

  private

    def set_item
      @item =  Item.find_by(id: params[:id], user_id: current_user)    
    end

    def set_location
      @location = Location.find(params[:location_id])
    end

    def item_params
      params.require(:itm).permit(:title, :description, :is_out)
    end

end
