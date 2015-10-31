class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :ratings, as: :rateable
  has_many :rates, through: :ratings
  has_many :sponsored_posts, dependent: :destroy

  validates :name, length: {minimum: 5}, presence: true
  validates :description, length: {minimum: 15}, presence: true 

  scope :visible_to, -> (user) { user ? all : publicly_viewable }
  scope :publicly_viewable, -> { Topic.where(public: true) }
  scope :privately_viewable, -> { Topic.where(public: false) }
end
