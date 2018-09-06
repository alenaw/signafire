class User < ApplicationRecord
  has_and_belongs_to_many :elastic_indices
  validates :name, presence: true, uniqueness: true
end
