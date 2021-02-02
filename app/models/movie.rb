class Movie < ApplicationRecord
  belongs_to :production_company
  validates :title, uniqueness: true
  validates :title, :year, :duration, :description, :average_vote, presence: true
  validates :year, :duration, numericality: { only_integer: true }
  validates :average_vote, numericality: true
end
