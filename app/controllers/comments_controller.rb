
class CommentsController < ApplicationController
  before_action :set_item, only: [:create]
  before_action :set_comment, only: [:create_reply]

  def create
    @comment = @item.comments.build(comment_params)
    @comment.user = current_user 

    if @comment.save
      redirect_to @item, notice: 'Comment was successfully created.'
    else
      redirect_to @item, alert: 'Failed to create comment.'
    end
  end

  def create_reply
    @reply = @comment.replies.build(comment_params)
    @reply.user = current_user 

    if @reply.save
      redirect_to @item, notice: 'Reply was successfully created.'
    else
      redirect_to @item, alert: 'Failed to create reply.'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
