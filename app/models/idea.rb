class Idea < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, uniqueness: true
  validates :description, length: {minimum: 5}
end
