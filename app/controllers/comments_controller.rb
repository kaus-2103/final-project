
class CommentsController < ApplicationController
    before_action :set_item
  
    def create
      @comment = @item.comments.build(comment_params)
      @comment.user = current_user 
  
      if @comment.save
        redirect_to @item, notice: 'Comment was successfully created.'
      else
        redirect_to @item, alert: 'Failed to create comment.'
      end
    end
  
    private
  
    def set_item
      @item = Item.find(params[:item_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  