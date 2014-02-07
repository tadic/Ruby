require 'spec_helper'

describe "Beer is" do
  include OwnTestHelper
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "saved when beer_name is not empty" do
    visit new_beer_path
    select('Koff', from:'beer[brewery_id]')
    select('Weizen', from:'beer[style]')
    fill_in('beer[name]', with:'Beer')
 
    expect{ click_button "Create Beer"}.to change{Beer.count}.from(0).to(1)

    expect(Beer.all.count).to eq(1)  
  end
  it "not saved when beer_name is empty" do
    visit new_beer_path
    select('Koff', from:'beer[brewery_id]')
    select('Weizen', from:'beer[style]')
 
  click_button "Create Beer"
    expect(Beer.count).to eq(0)
    expect(page).to have_content 'Name is too short (minimum is 3 characters)'
  end
end