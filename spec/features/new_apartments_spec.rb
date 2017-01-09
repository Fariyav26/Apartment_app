require 'rails_helper'

RSpec.feature "NewApartments", type: :feature do
  context 'Creating a new apartment listing' do
    Steps 'Creating a new apartment lisiting' do
      Given 'I am on the new apartment page' do
        visit 'apartments/new'
      end
      Then 'I can fill in the street 1, street 2, city, postal, state, country, contact name, phone, hours' do
        fill_in 'Street1', with: '123 Main St'
        fill_in 'Street2', with: 'Ste 1'
        fill_in 'City', with: 'Los Angeles'
        fill_in 'Postal', with: '92108'
        fill_in 'State', with: 'CA'
        fill_in 'Country', with: 'USA'
        fill_in 'Contact name', with: 'Steve'
        fill_in 'Phone', with: '619-303-3030'
        fill_in 'Hours', with: '5:00pm - 9:00pm'
      end
      And 'I can click Create Apartment' do
        click_button 'Create Apartment'
      end
      And 'I can see content on page' do
        expect(page).to have_content('Apartment was successfully created.')
      end
    end
  end
end
