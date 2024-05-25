class Item < ApplicationRecord
  serialize :tags, coder: JSON
  belongs_to :user
  belongs_to :collection
  has_many :comments, dependent: :destroy
end
