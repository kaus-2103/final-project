require 'redcarpet'
class Collection < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

 
  validates :name, :category, presence: true

  # CATEGORIES = ["Books", "Signs", "Silverware", "Other"]

  def custom_field_keys
     (custom_fields || {}).keys.map(&:to_sym)
  end
  def formatted_category
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(self.category).html_safe
  end
end
