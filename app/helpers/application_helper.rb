module ApplicationHelper
  include Pagy::Frontend

  def current_attendee
    Attendee.find_by_normalized_email(session[:email])
  end

  def yes_no_bool(bool)
    bool ? "Yes" : "No"
  end
end
