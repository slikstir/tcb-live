module Admin::ShowsHelper
  def showtime(show)
    show.date.strftime("%B %d, %Y") rescue "Unset"
  end
end
