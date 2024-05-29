class Item < ApplicationRecord
  serialize :tags, coder: JSON
  belongs_to :user
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :pic
  def copy_and_transform_custom_fields_from_collection
    self.custom_field = transform_custom_fields(collection.custom_fields)
  end

  private

  def transform_custom_fields(custom_fields)
    custom_fields.values.map { |field_value| [field_value,""] }.to_h
  end
end
