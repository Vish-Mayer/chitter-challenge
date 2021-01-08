require 'bcrypt'
require 'json'

class User

  def self.all
    result = DatabaseConnection.query('
      SELECT *
      FROM users
      ')
    result.map { |user|
      User.new(id: user['id'], username: user['username'], email: user['email'])
    }
  end

  def self.allUsernames
    usernames = []
    result = DatabaseConnection.query('
      SELECT username
      FROM users
      ')
    result.map { |user| usernames << { username: user['username'] }}
    usernames.to_json
  end

  def self.create(username:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("
      INSERT
      INTO users (username, email, password)
      VALUES ('#{username}', '#{email}', '#{encrypted_password}')
      RETURNING id, username, email;
    ")
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  def self.find(id:)
    return nil unless id

    result = DatabaseConnection.query("
      SELECT *
      FROM users
      WHERE id = '#{id}'
    ")
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  def self.where(peep_id:)
    search = DatabaseConnection.query("
      SELECT user_id, username, email
      FROM user_peep as UP
      INNER JOIN
      users as US
      ON UP.user_id = US.id
      WHERE peep_id = '#{peep_id}'
    ")
    result = search.map { |all| all }
    result.map { |user| User.new(id: user['user_id'], username: user['username'], email: user['email']) }
  end

  def self.comments(comment_id:)
    search = DatabaseConnection.query("
      SELECT user_id, username, email
      FROM user_comment as UC
      INNER JOIN
      users as US
      on UC.user_id = US.id
      WHERE comment_id = #{comment_id}
    ")
    result = search.map { |all| all }
    result.map { |user| User.new(id: user['user_id'], username: user['username'], email: user['email']) }
  end

  def self.replies(reply_id:)
    search = DatabaseConnection.query("
      SELECT *
      FROM user_reply as UR
      INNER JOIN
      users as US
      on UR.user_id = US.id
      WHERE reply_id = #{reply_id}
    ")
    result = search.map { |all| all }
    result.map { |user| User.new(id: user['user_id'], username: user['username'], email: user['email']) }
  end


  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("
      SELECT *
      FROM users
      WHERE email = '#{email}'
      ")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password

    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  def self.already_exists?(username:, email:)
    username = DatabaseConnection.query("SELECT id FROM users WHERE username='#{username}'")
    email = DatabaseConnection.query("SELECT id FROM users WHERE email='#{email}'")
    return true if email.any? || username.any?

    false
  end

  def self.scan(body:)
    result = body.to_enum(:scan, /(?:\s|^)(?:@(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i ).map { Regexp.last_match }
    result.join.split(" ").map { |user| user.delete('@') }
  end

  attr_reader :id, :email, :username

  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end

  def peeps(peep_class = Peep)
    peep_class.users(user_id: id)
  end

  def tagged_peeps(peep_class = Peep)
    peep_class.tagged_users(tagged_user_id: id)
  end

  def mentioned_peeps(peep_class = Peep)
    peep_class.mentioned_users(mentioned_user_id: id)
  end

  def activity(peep_class = Peep)
    peep_class.user_activity(recipient_id: id)
  end
end
