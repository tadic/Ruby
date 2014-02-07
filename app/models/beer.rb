
class Beer < ActiveRecord::Base
  include RatingAverage
  

  validates :name, length: { minimum: 3 }
  validates :style, presence: true
  
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, through: :ratings, source: :user 

  
  
  def to_s
      name + " (" + brewery.name + ")"
  end
  
  
end
