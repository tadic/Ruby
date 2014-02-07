require 'spec_helper'

describe "Rating" do
  include OwnTestHelper
  
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
 let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery}
 let!(:user) { FactoryGirl.create :user }
 let!(:user2) { FactoryGirl.create :user2 }  
  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
    Rating.first.destroy unless nil?  #???????????????????????????????????????????????????????????????????????????????????????????
  end

  it "when given, is registered to the beer and user who is signed in" do
    FactoryGirl.reload
    puts "ukupno: " + Rating.count.to_s
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
  describe "if exist" do
   
    it "are showed on rating page" do
       rating = Rating.new beer_id: beer2.id, score: 14
        rating2 = Rating.new beer_id: beer1.id, score: 17
        rating3 = Rating.new beer_id: beer1.id, score: 13
        user.ratings << rating
        user2.ratings << rating2
        user2.ratings << rating3
        visit ratings_path
        expect(page).to have_content 'Karhu 14 Pekka'
        expect(page).to have_content 'iso 3 17 Ivan'
        expect(page).to have_content 'iso 3 13 Ivan'
    
      end
    it "only users rating can be on his own page" do
      rating = Rating.new beer_id: beer2.id, score: 14
        rating2 = Rating.new beer_id: beer1.id, score: 17
        rating3 = Rating.new beer_id: beer1.id, score: 13
        user.ratings << rating
        user2.ratings << rating2
        user2.ratings << rating3
        visit user_path(user)
        expect(page).not_to have_content 'iso 3 17 Ivan'
        expect(page).to have_content 'Pekka Has made 1 rating'
        expect(page).to have_content 'Karhu 14'
    
    end
    it "is deleted from db if user clicked delete" do
        rating2 = Rating.new beer_id: beer1.id, score: 17
        rating3 = Rating.new beer_id: beer1.id, score: 13
        user.ratings << rating2
        user.ratings << rating3
        visit user_path(user)
        expect(page).to have_content 'iso 3 13 delete'
        expect(page).to have_content 'Pekka Has made 2 ratings'
        page.all('a')[10].click
        expect(page).not_to have_content 'iso 3 13 delete'
        expect(page).to have_content 'Pekka Has made 1 rating'
        save_and_open_page
        
    end

  end
  

end