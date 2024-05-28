class AddCustomKToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :custom_k, :json
  end
end
