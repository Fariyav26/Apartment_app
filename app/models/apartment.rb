class Apartment < ActiveRecord::Base
  belongs_to :user
  geocoded_by :full_address
  after_validation :geocode
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }

  def full_address
    street1 + ', ' + street2 + ', ' + city + ", " + state + ", " + postal + ', ' + country
  end

  resourcify
  # as a user I can see the apartment listing and nothing else..

end
