class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

 
  validates :name, :category, presence: true

  CATEGORIES = ["Books", "Signs", "Silverware", "Other"].freeze

   def custom_field_keys
     (custom_fields || {}).keys.map(&:to_sym)
   end
end
