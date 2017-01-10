require 'rails_helper'

RSpec.feature "LandingPages", type: :feature do
  context 'Going to the landing page' do
    Steps 'Being Welcomed' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can see a list of apartments' do
        expect(page).to have_content("Listing Apartments")
      end
      And 'I can see the listed apartments shown on a map' do
        expect(page).to have_css('div#map_location_all')
      end
    end
  end

  context 'I can click to a link that takes me to where I can create a new apartment listing' do
    Steps 'Click link' do
      Given 'I am on the landing page' do
        visit '/'
      end
      Then 'I can click New Apartment link' do
        click_link 'New Apartment'
      end
    end
  end

end
