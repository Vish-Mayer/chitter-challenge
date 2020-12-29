require 'date'

class ConvertDate

  CURRENT_DATE = DateTime.new(Time.now.strftime('%Y').to_i, Time.now.strftime('%m').to_i, Time.now.strftime('%d').to_i)

  def self.where(date:, current_date: CURRENT_DATE)
    value = date.split("-")
    input_date = DateTime.new(value[0].to_i, value[1].to_i, value[2].to_i)
    answer = current_date - input_date
    answer = answer.to_s[0...-2].to_i

    if answer == 0
      "today"
    elsif answer == 1
      "yesterday"
    elsif answer > 1
      "#{answer} days ago"
    end
  end
end
