
class Beer < ActiveRecord::Base
  include RatingAverage
  
  validates :name, uniqueness: true
  validates :name, length: { minimum: 3 }
  
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, through: :ratings, source: :user 

  
  
  def to_s
      name + " (" + brewery.name + ")"
  end
  
  
end
