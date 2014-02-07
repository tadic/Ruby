require 'spec_helper'
BeerClub
BeerClubsController
Membership
MembershipsController

describe Beer do
  it "can not exists without name" do
    beer = Beer.new style:"style1"

    expect(beer).not_to be_valid
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Olut1"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)

  end
  
    it "is saved with correct name and style" do
      beer = Beer.create name:"Beer1", style:"Style1"

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

end