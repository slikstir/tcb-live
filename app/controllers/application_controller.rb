class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  def attendee_logged_in?
    current_attendee.present?
  end

  def current_attendee
    Attendee.find_by_normalized_email(session[:email])
  end
end
