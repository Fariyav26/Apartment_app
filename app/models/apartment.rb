class Apartment < ActiveRecord::Base
  geocoded_by :full_address
  after_validation :geocode

  def full_address
    street1 + ', ' + street2 + ', ' + city + ", " + state + ", " + postal + ', ' + country 
  end
end
