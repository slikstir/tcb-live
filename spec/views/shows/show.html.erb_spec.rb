require 'rails_helper'

RSpec.describe "shows/show.html.erb", type: :view do
  let(:show) { create(:show, footer: "Show Footer") }

  before do
    assign(:show, show)
  end

  context 'when a setting for footer is set' do
    let(:setting) { create(:setting, name: "footer", value: "Custom Footer") }

    before do
      assign(:footer, setting.value)
    end

    it "renders the turbo stream for page reload" do
      render
      expect(rendered).to include(setting.value)
    end
  end
end
