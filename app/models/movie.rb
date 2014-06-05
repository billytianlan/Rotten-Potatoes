class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, :director, :description, :image, :release_date, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validate :release_date_is_in_the_future

  def review_average
    if reviews.size == 0 
      puts "No Reviews"
    else
    reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  scope :search, -> movie, runtime_in_minutes { where "title like ? AND director like ? #{runtime_in_minutes}", "%#{movie}%", "%#{movie}%" }

  protected

  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end
end

