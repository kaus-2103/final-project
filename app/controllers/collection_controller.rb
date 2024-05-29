class CollectionController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_collection, only: [:edit, :update, :show, :destroy]

  def new
    @collection = current_user.collections.build
  end
  
  def create
    Rails.logger.debug "Params: #{params.inspect}"
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      redirect_to root_path, notice: 'Collection was successfully created.'
    else
      render :new, locals: { error_messages: @collection.errors.full_messages }
    end
  end

  def edit
    @collection 
  end

  def update
    if @collection.update(collection_params)
      redirect_to item_history_path, notice: 'Collection was successfully updated.'
    else
      render :edit
    end
  end

  def show
    @items = @collection.items
  end

  def destroy
    @collection.destroy
    redirect_to root_path, notice: "Collection was successfully deleted." 
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :category, :image, custom_fields: {}, custom_field_types: {})
  end
end
