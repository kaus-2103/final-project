class LikesController < ApplicationController
    def create
        item = Item.find(params[:item_id])
        like = current_user.likes.build(item: item)
    
        if like.save
          flash[:notice] = "You liked this item."
        else
          flash[:alert] = "You can't like this item more than once."
        end
    
        redirect_to item_path(item)
      end
    
    def destroy
        item = Item.find(params[:item_id])
        like = current_user.likes.find_by(item: item)
    
        if like.destroy
          flash[:notice] = "You unliked this item."
        else
          flash[:alert] = "Something went wrong."
        end
    
        redirect_to item_path(item)
    end
end
