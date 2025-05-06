require 'rails_helper'

RSpec.describe 'Attendee Account Interactions', type: :feature, js: true do
  feature 'As an attendee' do
    context 'Given there is a live show' do
      let!(:show) { create(:show) }

      scenario 'I can visit the homepage and join the show in preshow' do
        visit root_path
        expect(page).to have_content(/get ready to participate in the show!/i)
        fill_in "Name", with: Faker::Name.name
        fill_in "Email", with: Faker::Internet.email
        fill_in "Show code", with: show.code
        click_button "Join Show"
        expect(page).to have_content(/you're ready for the show/i)
      end

      scenario 'Once logged in, I can edit my name and email'
    end
  end
end
