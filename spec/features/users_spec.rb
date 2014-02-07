require 'spec_helper'

include OwnTestHelper

describe "User" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
   let!(:user) { FactoryGirl.create :user }
  before :each do
    #FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
  it "can see favorite beer style and brewery" do
    sign_in(username:"Pekka", password:"Foobar1")
     rating = Rating.new beer_id: beer1.id, score: 14
     user.ratings << rating
     visit user_path(user)
     expect(page).to have_content 'Pekka Has made 1 rating'
     expect(page).to have_content 'Favorite style: Lager'
     expect(page).to have_content 'Favorite brewery: Koff'
     
  end
end