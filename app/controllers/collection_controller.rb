class CollectionController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:edit, :update, :show]

  def new
    @collection = current_user.collections.build
  end
  
  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      redirect_to root_path, notice: 'Collection was successfully created.'
    else
      render :new
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

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :category, :image, custom_fields: {})
  end
end
