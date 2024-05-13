class ItemController < ApplicationController
  before_action :authenticate_user!
  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: "Item was successfully created."
    else
      render :new
    end
  end

  def history
    @user = current_user
    @items = current_user.items
  end

  def show 
    @item = Item.find(params[:id])
  end

  def category
    @category = params[:category]
    @items = Item.where(category: @category)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :image)
  end
end
