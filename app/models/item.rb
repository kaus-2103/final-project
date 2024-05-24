class Item < ApplicationRecord
  serialize :tags, coder: JSON
  belongs_to :user
  has_many :comments, dependent: :destroy
end
