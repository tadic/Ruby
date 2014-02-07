require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  
  it "is not saved with to short password" do
    user = User.create username:"Pekka", password:"S1", password_confirmation:"S1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  it "is not saved with password which has not containt numbers" do
    user = User.create username:"Pekka", password:"Salasana", password_confirmation:"Salasana"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
end
  

describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
    
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

         expect(user.favorite_beer).to eq(beer)
    end
    
     def create_beer_with_rating(score, user)
       FactoryGirl.reload
      beer = FactoryGirl.create(:beer)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
 
     def create_beers_with_ratings(*scores, user)
       scores.each do |score|
       create_beer_with_rating(score, user)
     end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end 
end
   




describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end
    
  
    def create_beer_with_rating_and_style(style,score, user)
      FactoryGirl.reload
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
    
    def create_beer_with_style_and_ratings(style, *scores, user)
        scores.each do |score|
           create_beer_with_rating_and_style(style, score, user)
        end
    end
   
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_style).to eq(beer.style)
    end
    
    it "is the higest rated style" do
      create_beer_with_style_and_ratings("Style1",10, 20, 15, 7, 9, user)
      create_beer_with_style_and_ratings("Style2",10, 20, user)
      create_beer_with_style_and_ratings("Style3",10, user)
      
      expect(user.favorite_style).to eq("Style2")
    end
  
end
     
describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end
    
  
    def create_beer_with_rating_and_brew(name,score, user)
      FactoryGirl.reload
      brewery = Brewery.create name:name, year:1234
      beer = FactoryGirl.create(:beer, brewery:brewery)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
    end
    
    def create_beer_with_brew_and_ratings(brew, *scores, user)
        scores.each do |score|
           create_beer_with_rating_and_brew(brew, score, user)
        end
    end
   
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end
    
    it "is the higest rated brewery" do
      create_beer_with_brew_and_ratings("Brew1",10, 20, 15, 7, 9, user)
      create_beer_with_brew_and_ratings("Brew2",10, 20, user)
      create_beer_with_brew_and_ratings("Brew3",18, user)
      
      expect(user.favorite_brewery).to eq("Brew3")
    end
  
end





     
    
 
 
describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do

      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  
end