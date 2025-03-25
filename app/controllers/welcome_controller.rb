class WelcomeController < ApplicationController
  def index
    @attendee = current_attendee || Attendee.new
  end
end
