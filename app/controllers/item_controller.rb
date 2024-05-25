class ItemController < ApplicationController
  before_action :authenticate_user!
  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    @item.tags = params[:item][:tags].split(',').map(&:strip) if params[:item][:tags].present?
    if @item.save
      redirect_to root_path, notice: "Item was successfully created."
    else
      render :new
    end
  end

  def history
    @user = current_user
    @items = current_user.items
    @collections = current_user.collections
  end

  def show 
    @item = Item.find(params[:id])
  end

  def category
    @category = params[:category]
    @items = Item.where(category: @category)
  end

  
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, :image,:tags,:collection_id)
  end
end
