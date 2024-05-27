class ItemController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:new, :create, :destroy, :update, :edit]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  def new
    collection = @collection
    @item = collection.items.build
    @item.copy_and_transform_custom_fields_from_collection
  end

  def create
    @item = current_user.items.build(item_params)
    @item.copy_and_transform_custom_fields_from_collection
    Rails.logger.debug "Items found: #{@item_params}"
    if params[:item][:custom_fields].present?
      @item.custom_field = params[:item][:custom_fields]
    end
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
    @item 
  end

  def category
    @category = params[:category]
    @items = Item.where(category: @category)
  end

  def edit
    @item 
    @collection
  end

  def update
    if @item.update(item_params)
      redirect_to item_history_path, notice: 'Collection was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: "Item was successfully deleted."
  end

  
  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category, :image,:tags,:collection_id, custom_field: {})
  end
end
