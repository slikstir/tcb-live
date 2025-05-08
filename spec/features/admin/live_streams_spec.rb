  require 'rails_helper'

RSpec.describe 'Admin/LiveStreams', type: :feature, js: true do
  context 'As an admin' do
    include_context 'Logged into admin'

    context 'and there I have already made a show do' do
      include_context "with a live show and two multiple-choice polls"

      before { visit admin_show_path(show) }

      scenario 'I can add a live stream to the show' do
        click_link "Add Live Stream"
        fill_in 'Name', with: 'Test Live Stream'
        fill_in 'Code', with: 'TWITCHLIVE'
        fill_in 'Description', with: 'Test Description'
        fill_in 'Stream delay', with: '10'
        click_button 'Create Live stream'
        expect(page).to have_content('Live stream was successfully created.')
      end

      context 'and I have already created a live stream' do
        let(:live_stream) { create(:live_stream, show: show) }
        let(:live_stream_poll) { live_stream.live_stream_polls.find_by(poll: p1) }

        scenario 'I can edit the live stream, and assign individual delays to the polls' do
          visit admin_show_live_stream_path(show, live_stream)
          within('#live-stream-header') do
            click_link 'Edit'
          end

          within("[data-poll-id='#{p1.id}']") do
            fill_in 'Stream delay', with: '5'
            select "Yes", from: "Count votes"
          end

          click_button 'Update Live stream'
          expect(page).to have_content('Live stream was successfully updated.')
          expect(live_stream_poll.stream_delay).to eq(5)
          expect(live_stream_poll.count_votes).to eq(true)
        end
      end
    end
  end
end
