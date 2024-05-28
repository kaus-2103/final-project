class AddCustomFieldTypesToCollections < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :custom_field_types, :json
  end
end
