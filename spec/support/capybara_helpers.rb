module CapybaraHelpers
  def sign_in_as_attendee(email:, show_code:)
    visit root_path
    expect(page).to have_content(/get ready to participate in the show!/i)
    fill_in "Name", with: Faker::Name.name
    fill_in "Email", with: email
    fill_in "Show code", with: show_code
    click_button "Join Show"
  end

  # Clicks a choice based on visible label text, like "Blue"
  def click_vote_choice_by_text(text)
    find('label.choice-label', text: /#{Regexp.escape(text)}/i).click
  end

  # Clicks a choice based on a choice object with an ID
  def click_vote_choice(choice)
    find("input#vote_choice_#{choice.id}", visible: false).click
  end
end
