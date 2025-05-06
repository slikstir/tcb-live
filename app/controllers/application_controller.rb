class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  def find_settings
    @footer = Setting.find_by(code: "footer").try(:value)
  end

  def check_for_attendee_logged_in
    redirect_to root_path, alert: "Please sign up!" unless attendee_logged_in?
  end

  def attendee_logged_in?
    current_attendee.present?
  end

  def current_attendee
    @current_attendee = Attendee.find_by_normalized_email(session[:email])
  end
end
