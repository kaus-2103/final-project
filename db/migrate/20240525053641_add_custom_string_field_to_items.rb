class AddCustomStringFieldToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :custom_string_field1, :json
    add_column :items, :custom_string_field2, :json
    add_column :items, :custom_string_field3, :json
  end
end
