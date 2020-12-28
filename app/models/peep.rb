require 'date'

class Peep

  def self.all
    result = DatabaseConnection.query('
      SELECT *
      FROM peeps
      Order by id DESC
      ')
    result.map { |peep|
    Peep.new(id: peep['id'], body: peep['body'], date: peep['date']) }
  end

  def self.create(body:)
    result = DatabaseConnection.query("
      INSERT
      INTO peeps (body, date)
      VALUES ('#{body}', NOW())
      RETURNING id, body, date ;
      ")
    Peep.new(id: result[0]['id'], body: result[0]['body'], date: result[0]['date'])
  end

  attr_reader :id, :body, :date

  def initialize(id:, body:, date: )
    @id = id
    @body = body
    @date = date
  end

  def user(user_class = User)
    user_class.where(peep_id: id)
  end

  def hashtags(hashtag_class = HashTag)
    hashtag_class.where(peep_id: id)
  end

  def created_at(convert_date_class = ConvertDate)
    convert_date_class.where(date: date)
  end
end
