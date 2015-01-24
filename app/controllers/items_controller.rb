class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index]
  before_action :set_location
  before_action :set_item, only: [:show, :edit, :update, :destroy, :index]
  before_action :set_items, only: [:index]
  
  
  
    def index
      @user = User.find(@location.user_id)
    end

    def show

    end


    def new

      @item = @user.items.build
      @record = @item.records.build

    end

  def create
      @item = @location.items.build(item_params)
      @item.user_id = @user.id

      if @item.save
        flash[:success] = "Item #{@item.name} added."
        redirect_to location_items_path(@location)
      else
        render 'new'
      end
    end

    def update
      if @task.update_attributes(item_params)
        redirect_to location_item_path(@location)
      else
        flash[:danger] = "Item creation faild"
        render 'edit'
      end
    end

    def destroy
      @item.delete
      redirect_to location_items_path(@location)
    end
 
  private

    def set_user
      @user = current_user
    end

    def set_location
      @location = current_user.locations.find(params[:location_id])
    end

    def set_items
      @items =  @location.items
    end

    def set_item
      @item =  Item.find_by(id: params[:id], user_id: current_user)  
    end

    def item_params
      params.require(:item).permit(:name, :description, :is_out, :date_due, :tag_list, :avatar, records_attributes: [:date_due, :borrower_name])
    end
end
