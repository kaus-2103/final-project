class RemoveCustomStringFieldsFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :custom_string_field1, :json
    remove_column :items, :custom_string_field2, :json
    remove_column :items, :custom_string_field3, :json
  end
end
