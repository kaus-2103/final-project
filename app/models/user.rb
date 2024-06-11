class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :items
         has_many :comments, dependent: :destroy
         has_many :collections, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :api_tokens
         validates :accountId, uniqueness: true, allow_nil: true
         def generate_api_token
          api_tokens.create(token: SecureRandom.hex(32))
        end
        end
