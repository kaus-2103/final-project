class Ticket < ApplicationRecord
    validates :summary, presence: true
    validates :priority, presence: true
    validates :key, presence: true
end
