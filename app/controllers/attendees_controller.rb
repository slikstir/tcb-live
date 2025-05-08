class AttendeesController < ApplicationController
  def create
    @attendee = Attendee.find_by_normalized_email(permitted_params[:email])
    @attendee = Attendee.new(email: permitted_params[:email]) if @attendee.blank?
    @attendee.name = permitted_params[:name]
    @attendee.save
    session[:email] = @attendee.email

    live_stream = LiveStream.find_by("LOWER(code) = ?", permitted_params[:show_code].downcase)
    show = Show.find_by("LOWER(code) = ?", permitted_params[:show_code].downcase)

    if live_stream.present?
      # Associate the attendee with the LiveStream and redirect to its parent Show
      live_stream.attendees << @attendee unless live_stream.attendees.exists?(id: @attendee.id)
      session[:show_code] = permitted_params[:show_code].downcase
      redirect_to show_path(live_stream.show.code), notice: "You're in! Sit back and get ready for the show"
    elsif show.present?
      if !(show.live? || show.preshow?)
        redirect_to root_path, alert: "Sorry, but that show isn't live"
      else
        show.attendees << @attendee unless show.attendees.exists?(id: @attendee.id)
        session[:show_code] = permitted_params[:show_code].downcase
        redirect_to show_path(show.code), notice: "You're in! Sit back and get ready for the show"
      end
    else
      # Not found
      redirect_to root_path, alert: "A show with the code #{permitted_params[:show_code]} wasn't found"
    end
  end

  private

  def permitted_params
    params.require(:attendee).permit(:email, :name, :show_code)
  end
end
