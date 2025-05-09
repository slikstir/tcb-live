require 'rails_helper'
require 'active_support/testing/time_helpers'

RSpec.describe 'Attendee Voting Interactions', type: :feature, js: true do
  include ActiveSupport::Testing::TimeHelpers
  include ActiveJob::TestHelper
  
  let(:email) { Faker::Internet.email }
  feature 'As an attendee who has joined a live show with two multiple-choice polls' do
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
    include_context "with a live show with a yes-no poll" do
    end
  end

  feature 'As an attendee who has joined a live strean for a show with two multiple-choice polls' do
    include_context "with a live stream and two multiple-choice polls"

    include_context "with a live stream and two multiple-choice polls" do
      feature ' I can vote in a poll' do
        context 'and the live_stream_poll#count_votes is false' do
          before(:each) do
            live_stream.live_stream_polls.update_all(count_votes: false)
          end

          scenario 'the votes are not counted for the show' do
            p2.update(state: 'open')
            p2.live_stream_poll.update(state: 'open')

            sign_in_as_attendee(email: email, show_code: live_stream.code)
            expect(page).to have_css("#live_stream_#{live_stream.id}", visible: :all)
            expect(page).to have_case_insensitive_content(p1.question)
            expect(page).to have_case_insensitive_content(p1c1.title)
            expect(page).to have_case_insensitive_content(p1c2.title)
            expect(page).to have_case_insensitive_content(p1c3.title)
            click_vote_choice_by_text(p1c1.title)
            click_button "Vote"
            expect(p1c1.reload.votes_count).to eq(0)

            expect(page).to have_css("#live_stream_#{live_stream.id}", visible: :all)
            expect(page).to have_case_insensitive_content(p2.question)
            expect(page).to have_case_insensitive_content(p2c1.title)
            expect(page).to have_case_insensitive_content(p2c2.title)
            expect(page).to have_case_insensitive_content(p2c3.title)
            click_vote_choice_by_text(p2c1.title)
            click_button "Vote"
            expect(page).to have_case_insensitive_content("Vote submitted")

            expect(p2c1.reload.votes_count).to eq(0)
          end
        end

        context 'and the live_stream_poll#count_votes is true' do
          before(:each) do
            live_stream.live_stream_polls.update_all(count_votes: true)
          end

          scenario 'the votes are  counted for the show' do
            sign_in_as_attendee(email: email, show_code: live_stream.code)
            expect(page).to have_css("#live_stream_#{live_stream.id}", visible: :all)
            expect(page).to have_case_insensitive_content(p1.question)
            expect(page).to have_case_insensitive_content(p1c1.title)
            expect(page).to have_case_insensitive_content(p1c2.title)
            expect(page).to have_case_insensitive_content(p1c3.title)
            click_vote_choice_by_text(p1c1.title)
            click_button "Vote"
            expect(page).to have_case_insensitive_content("Vote submitted")

            expect(p1c1.reload.votes_count).to eq(1)
          end
        end
      end
    end
  end
end
