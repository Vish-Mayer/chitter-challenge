require 'date'

class Convert

  CURRENT_DATE = (DateTime.new(Time.now.strftime('%Y').to_i, Time.now.strftime('%m').to_i , Time.now.strftime('%d').to_i ))

  def self.date(date, current_date = CURRENT_DATE)
    value = date.split("-")
    input_date = (DateTime.new(value[0].to_i, value[1].to_i, value[2].to_i))

    answer = current_date - input_date

    if answer == (0/1)
      "today"
    end
  end
end
