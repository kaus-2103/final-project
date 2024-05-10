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

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :image)
  end
end
