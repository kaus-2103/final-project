class HomeController < ApplicationController
  def index
    @categories = Item.pluck(:category).uniq
    @collections = Collection.all.includes(:items).sort_by { |collection| -collection.items.size }.take(5)
    
    @latest_items = Item.order(created_at: :desc).limit(5)
    @most_used_tags = Item.pluck(:tags).flatten.group_by(&:itself).transform_values(&:count).sort_by { |_, count| -count }.take(5).to_h.keys
  end

  def items_by_category
    @category = params[:category]
    @items = Item.where(category: @category)
  end
  def update
    cookies[:theme] = params[:theme]
    redirect_to(request.referrer || root_path)
  end

  

  def search
    @query = params[:query].downcase.strip
    Rails.logger.debug "Search query: #{@query}"

    if @query.present?
      # Simplified item search
      @items = Item.where(
        'LOWER(name) LIKE :query OR LOWER(description) LIKE :query OR LOWER(tags) LIKE :query',
        query: "%#{@query.downcase}%"
      )
      

      Rails.logger.debug "Items found: #{@items.pluck(:name)}"

      # Simplified collection search
      @collections = Collection.where('LOWER(name) LIKE :query OR LOWER(description) LIKE :query', query: "%#{@query}%")
      Rails.logger.debug "Collections found: #{@collections.pluck(:name)}"

      @comments = Comment.where('LOWER(content) LIKE :query', query: "%#{@query}%")

      @comment_items = @comments.map(&:item).uniq

      @all_items = (@items + @comment_items).uniq
    else
      @items = Item.none
      @collections = Collection.none
      @comments = Comment.none
      @all_items = []
    end

    respond_to do |format|
      format.html # search.html.erb
      format.json { render json: { items: @items, collections: @collections } }
    end
  end
  
end

