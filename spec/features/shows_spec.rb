require 'rails_helper'

RSpec.feature "Shows", type: :feature do
  context 'I am on the show page' do
    Steps 'I am on the show page' do
      Given 'I am on the show page' do
        visit '/apartments'
      end
      Then 'I can see my location on the map' do
        expect(page).to have_css('div#map_current_location')
      end
    end
  end
end
