class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :items
         has_many :comments, dependent: :destroy
         has_many :collections, dependent: :destroy
         has_many :likes, dependent: :destroy
         validates :accountId, uniqueness: true, allow_nil: true
        end
