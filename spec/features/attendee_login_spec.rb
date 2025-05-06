require 'rails_helper'

RSpec.describe 'Attendee Account Interactions', type: :feature, js: true do
  feature 'As an attendee' do
    scenario 'I can visit the homepage' do
      visit root_path
      expect(page).to have_content(/get ready to participate in the show!/i)    end
  end
end
