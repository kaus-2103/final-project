class HomeController < ApplicationController
  def index
    @categories = Item.pluck(:category).uniq
  end

  def items_by_category
    @category = params[:category]
    @items = Item.where(category: @category)
  end
end
