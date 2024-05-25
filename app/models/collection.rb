class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  serialize :custom_fields, JSON

  validates :name, :category, presence: true

  CATEGORIES = ["Books", "Signs", "Silverware", "Other"].freeze

  def custom_field_names
    custom_fields.keys
  end
end
