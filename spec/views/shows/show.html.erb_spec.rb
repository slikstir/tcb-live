require 'rails_helper'

RSpec.describe "shows/show.html.erb", type: :view do
  let(:show) { create(:show, footer: "Show Footer") }

  before do
    assign(:show, show)
  end

  it 'renders a turbo stream for the show' do
    render
    expect(rendered).to include('<div id="show_page_reload"></div>')
    expect(rendered).to have_css("turbo-cable-stream-source[channel='Turbo::StreamsChannel']")
  end

  context 'when a setting for footer is set' do
    let(:setting) { create(:setting, name: "footer", value: "Custom Footer") }

    before do
      assign(:footer, setting.value)
    end

    it "renders the footer" do
      render
      expect(rendered).to include(setting.value)
    end
  end

  context 'when a live stream is present' do
    let(:live_stream) { create(:live_stream, show: show) }
    before do 
      assign(:live_stream, live_stream)
    end

    it 'renders a turbo stream for refreshing the live stream' do 
      render
      expect(rendered).to include('<div id="live_stream_page_reload"></div>')
      expect(rendered).to have_css("turbo-cable-stream-source[channel='Turbo::StreamsChannel']")
    end
  end
end
