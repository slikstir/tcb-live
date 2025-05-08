require 'rails_helper'

RSpec.describe "shows/show.html.erb", type: :view, pending: true do
  let(:show) { create(:show, template: template, footer: "Show Footer") }

  before do
    assign(:show, show)
    assign(:footer, nil)
  end

  it "renders the turbo stream for page reload" do
    render
    expect(rendered).to include('<turbo-stream action="append" target="page_reload">')
  end

  context "when the show has a template" do
    it "renders the template CSS" do
      render
      expect(rendered).to render_template('admin/templates/_css')
    end

    it "renders the Google Fonts embed if present" do
      render
      expect(rendered).to include("<link href='https://fonts.googleapis.com' rel='stylesheet'>")
    end
  end

  context "when the show is in preshow state" do
    before { allow(show).to receive(:preshow?).and_return(true) }

    it "renders the pre_show partial" do
      render
      expect(rendered).to render_template('shows/_pre_show')
    end
  end

  context "when the show is in postshow state" do
    before { allow(show).to receive(:postshow?).and_return(true) }

    it "renders the post_show partial" do
      render
      expect(rendered).to render_template('shows/_post_show')
    end
  end

  context "when the show is live and has active polls" do
    before do
      allow(show).to receive(:live?).and_return(true)
      allow(show).to receive(:active_polls?).and_return(true)
    end

    it "renders the poll partial" do
      render
# filepath: /Users/ricky/RailsApp/tcb-live/spec/views/shows/show.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "shows/show.html.erb", type: :view do
  let(:template) { create(:template, google_fonts_embed: "<link href='https://fonts.googleapis.com' rel='stylesheet'>") }
  let(:show) { create(:show, template: template, footer: "Show Footer") }

  before do
    assign(:show, show)
    assign(:footer, nil)
  end

  it "renders the turbo stream for page reload" do
    render
    expect(rendered).to include('<turbo-stream action="append" target="page_reload">')
  end

  context "when the show has a template" do
    it "renders the template CSS" do
      render
      expect(rendered).to render_template('admin/templates/_css')
    end

    it "renders the Google Fonts embed if present" do
      render
      expect(rendered).to include("<link href='https://fonts.googleapis.com' rel='stylesheet'>")
    end
  end

  context "when the show is in preshow state" do
    before { allow(show).to receive(:preshow?).and_return(true) }

    it "renders the pre_show partial" do
      render
      expect(rendered).to render_template('shows/_pre_show')
    end
  end

  context "when the show is in postshow state" do
    before { allow(show).to receive(:postshow?).and_return(true) }

    it "renders the post_show partial" do
      render
      expect(rendered).to render_template('shows/_post_show')
    end
  end

  context "when the show is live and has active polls" do
    before do
      allow(show).to receive(:live?).and_return(true)
      allow(show).to receive(:active_polls?).and_return(true)
    end

    it "renders the poll partial" do
      render