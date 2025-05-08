require 'rails_helper'

RSpec.describe 'Admin/LiveStreams', type: :feature, js: true do
  context 'As an admin' do
    include_context 'Logged into admin'

    context 'and there I have already made a show do' do
      let!(:show) { create(:show) }
      before { visit admin_show_path(show) }

      scenario 'I can add a live stream to the show' do
        click_link "Add Live Stream"
        fill_in 'Name', with: 'Test Live Stream'
        fill_in 'code', with: 'TWITCHLIVE'
        fill_in 'Description', with: 'Test Description'
        fill_in 'Stream delay', with: '10'
        click_button 'Create Live stream'
        expect(page).to have_content('Live stream was successfully created.')
      end

      context 'and I have already created a live stream' do
        let(:live_stream) { create(:live_stream, show: show) }
        scenario 'I can edit the live stream, and assign individual delays to the polls' do
          visit admin_show_live_stream_path(show, live_stream)
          sleep 10
          click_link 'Edit'
        end
      end
    end
  end
end
