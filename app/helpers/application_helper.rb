module ApplicationHelper
  include Pagy::Frontend

  def current_attendee
    Attendee.find_by_normalized_email(session[:email])
  end

end
