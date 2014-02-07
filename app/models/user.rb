class User < ActiveRecord::Base
  include RatingAverage
  has_secure_password
  
   validates :username, uniqueness: true

   validates :username, length: { minimum: 3, maximum: 15}
   validates :password, :format => {:with => /\A.*(?=.{4,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*\z/,
                                    message: "must be at least 4 characters and include one number and one big letter."}
                        
   
   has_many :ratings, dependent: :destroy
   has_many :memberships, dependent: :destroy
   has_many :beerclubs, through: :memberships, source: :beer_club
   has_many :beers, through: :ratings


  
  def to_s
      username.to_s
  end
  
 
    def favorite_beer
      return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
       ratings.order(score: :desc).limit(1).first.beer 
    end
    
    def get_style
      styles_count = Hash.new
      styles_values = Hash.new
      ratings.each {|e|
        if (styles_count[e.beer.style] == nil)
          styles_count[e.beer.style] = 1
          styles_values[e.beer.style] =  e.score
        else
            styles_count[e.beer.style] = styles_count[e.beer.style] + 1 
            styles_values[e.beer.style] =  styles_values[e.beer.style] + e.score
        end
      }
      styles_values.each {|key, value|
        styles_values[key] = value / styles_count[key]
      }
      return styles_values.key(styles_values.values.max)
    end
    
    def get_brew
      styles_count = Hash.new
      styles_values = Hash.new
      ratings.each {|e|
        name = e.beer.brewery.name
        if (styles_count[name] == nil)
          styles_count[name] = 1
          styles_values[name] =  e.score
        else
            styles_count[name] = styles_count[name] + 1 
            styles_values[name] =  styles_values[name] + e.score
        end
      }
      styles_values.each {|key, value|
        styles_values[key] = value / styles_count[key]
      }
      return styles_values.key(styles_values.values.max)
    end
    
    def favorite_style
      return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
      get_style
    end
    
    def favorite_brewery
      return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
      get_brew
    end
end
