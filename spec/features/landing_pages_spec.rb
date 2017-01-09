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
    end
  end

end
