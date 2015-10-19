class Rate < ActiveRecord::Base
  has_many :ratings
  belongs_to :rateable, polymorphic: true

  has_many :topics, through: :ratings, source: :rateable, source_type: :Topic
  has_many :posts, through: :ratings, source: :rateable, source_type: :Post
  
  enum stars: [:zero, :one, :two, :three, :four, :five]

  def self.update_rates(rate_string)
    new_rates = []

    unless rate_string.nil? || rate_string.empty?
      rate_string.split(",").each do |rate|
        rate_name = rate.strip
        new_rate = Rate.find_or_create_by(stars: rate_name)
        new_rates << new_rate
      end
    end
    new_rates
  end

end