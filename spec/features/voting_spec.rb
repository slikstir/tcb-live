require 'rails_helper'

RSpec.describe 'Attendee Voting Interactions', type: :feature, js: true do
  feature 'As an attendee who has joined a live show with two multiple-choice polls' do
    let(:email) { Faker::Internet.email }
    include_context "with a live show and two multiple-choice polls"

    context 'and I have not voted yet' do
      scenario 'I can vote in a poll' do
        sign_in_as_attendee(email: email, show_code: show.code)
        expect(page).to have_case_insensitive_content(p1.question)
        expect(page).to have_case_insensitive_content(p1c1.title)
        expect(page).to have_case_insensitive_content(p1c2.title)
        expect(page).to have_case_insensitive_content(p1c3.title)
        click_vote_choice_by_text(p1c1.title)
        click_button "Vote"
        expect(page).to have_case_insensitive_content("Vote submitted")
      end
    end

    context 'And the Ive already voted in the poll' do
      let!(:attendee) { create(:attendee, email: email) }
      let!(:attendee_vote) { create(:vote, attendee: attendee, poll: p1, choice: p1c1) }

      scenario 'The next question becomes available when it is assigned as open' do
        sign_in_as_attendee(email: email, show_code: show.code)
        expect(page).to have_case_insensitive_content("Vote submitted")
        p2.update(state: 'open')
        expect(page).to have_case_insensitive_content(p2.question)
        expect(page).to have_case_insensitive_content(p2c1.title)
        expect(page).to have_case_insensitive_content(p2c2.title)
        expect(page).to have_case_insensitive_content(p2c3.title)
        click_vote_choice_by_text(p2c3.title)
        click_button "Vote"
        expect(page).to have_case_insensitive_content("Vote submitted")
      end
    end
  end

  feature 'As an attendee who has joined a live show with a yes-no poll' do
  end
end
