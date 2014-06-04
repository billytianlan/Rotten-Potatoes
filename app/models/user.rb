class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :reviews

  def full_name
    "#{firstname} #{lastname}"
  end
  
end
