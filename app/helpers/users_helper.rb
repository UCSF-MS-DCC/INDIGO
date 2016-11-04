module UsersHelper
  def date_format(date)
    date.strftime("%d/%m/%Y %I:%M %p")
  end
end
