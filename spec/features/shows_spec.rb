require 'rails_helper'

RSpec.feature "Shows", type: :feature do
  context 'I am on the show page' do
    Steps 'I am on the show page' do
      Given 'I am on the show page' do
        visit '/apartments'
      end
    end
  end
end
