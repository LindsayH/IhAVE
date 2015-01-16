class LocationsController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_item

  def show
  end

  def index
    @locations = @user.locations
  end

  def new
    @location = Location.new
  end

  def create
    @location = @user.locations.build(location_params)
    @location.save
    redirect_to @location
  end

  def edit
  end

  def update
    if @location.update_attributes(location_params)
      redirect_to @location
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to locations_url
  end

  private

    def set_user 
       @user = current_user
    end 


    def set_item
      @item =  Item.find_by(id: params[:id], user_id: current_user)    
    end

    def set_location
     @location = current_user.locations.find_by(id: params[:id])
    end

    def item_params
      params.require(:item).permit(:title, :description, :is_out)
    end
    
    def location_params
      params.require(:location).permit(:name, :description)
    end

end
