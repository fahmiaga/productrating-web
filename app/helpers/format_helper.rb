module FormatHelper
  
  def format_price(price)
    # TODO: Format the price. 
    # - Display a dollar sign
    # - Display two decimal places
    return "$" + ('%.2f' % price).to_s
  end

  def format_date(date)
    return distance_of_time_in_words(date, Time.now)
  end

end
