require 'date'

class Peep

  def self.all
    result = DatabaseConnection.query('
      SELECT *
      FROM peeps
      Order by id DESC
    ')
    result.map { |peep|
      Peep.new(id: peep['id'], body: peep['body'], date: peep['date'])
    }
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

  def self.where(hashtag_id:)
    search = DatabaseConnection.query("
      SELECT *
      FROM hashtag_peep as HP
      INNER JOIN
      peeps as P
      ON HP.peep_id = P.id
      WHERE hashtag_id = #{hashtag_id}
      Order by P.id DESC
    ")
    result = search.map { |all| all }
    result.map { |peep| Peep.new(id: peep['peep_id'], body: peep['body'], date: peep['date']) }
  end

  def self.users(user_id:)
    search = DatabaseConnection.query("
      SELECT *
      FROM user_peep as UP
      INNER JOIN
      peeps as P
      ON UP.peep_id = P.id
      WHERE user_id = #{user_id}
      Order by P.id DESC
    ")
    result = search.map { |all| all }
    result.map { |peep| Peep.new(id: peep['peep_id'], body: peep['body'], date: peep['date']) }
  end

  def self.tagged_users(tagged_user_id:)
    search = DatabaseConnection.query("
      SELECT P.id peep_id, U.username author, body, date, US.username tagger
      FROM tag_user AS TU
      INNER JOIN
      users as US
      on TU.user_id = US.id
      INNER JOIN peeps AS P
      on TU.peep_id = P.id
      INNER JOIN
      user_peep as UP
      on TU.peep_id = UP.peep_id
      INNER JOIN
      users as U
      on UP.user_id = U.id
      WHERE tagged_user_id = #{tagged_user_id}
      Order by P.id DESC
    ")
    result = search.map { |all| all }
    result.map { |peep| [ Peep.new(id: peep['peep_id'], body: peep['body'], date: peep['date']), tagged_by: peep['tagger'] ]}
  end

  attr_reader :id, :body, :date

  def initialize(id:, body:, date:)
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
