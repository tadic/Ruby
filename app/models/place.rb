class Place
  include ActiveModel::Model
  attr_accessor :id, :name, :status, :reviewlink, :proxylink, :blogmap, :street, :city, :state, :zip, :country, :phone, :overall, :imagecount

  def self.rendered_fields
    [:id, :name, :status, :street, :city, :zip, :country, :overall ]
  end
  def self.empty
    name==nil
  end
  def path
    'places/' + id.to_s
  end
end