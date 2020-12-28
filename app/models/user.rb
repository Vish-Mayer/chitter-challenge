require 'bcrypt'

class User

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

  attr_reader :id, :email, :username

  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end
end
