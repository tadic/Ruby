class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  
   validates :username, uniqueness: true
   #validates :beerclubs, uniqueness: true
  validates :username, length: { minimum: 3, maximum: 15}
   validates :password, :format => {:with => /\A.*(?=.{4,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/,
                                    message: "must be at least 4 characters and include one number and one big letter."}
                        
   
   has_many :ratings
   has_many :memberships
   has_many :beerclubs, through: :memberships, source: :beer_club
   has_many :beers, through: :ratings


  
  def to_s
      username.to_s
  end
end
