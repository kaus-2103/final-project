module ApplicationHelper
    def like_button_for(item, user)
        if item.liked_by?(user)
          button_to t('unlike'), item_like_path(item), method: :delete, class: "btn btn-danger"
        else
          button_to t('like'), item_like_path(item), class: "btn btn-primary"
        end
      end
end
