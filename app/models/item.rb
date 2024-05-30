class Item < ApplicationRecord
  serialize :tags, coder: JSON
  belongs_to :user
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :pic

  def liked_by?(user)
    liked_users.include?(user)
  end
  def copy_and_transform_custom_fields_from_collection
    self.custom_field = transform_custom_fields(collection.custom_fields)
  end

  private

  def transform_custom_fields(custom_fields)
    custom_fields.values.map { |field_value| [field_value,""] }.to_h
  end
end
