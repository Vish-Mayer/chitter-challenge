class User

  def self.create(username:, email:, password:)
    result = DatabaseConnection.query("
      INSERT
      INTO users (username, email, password)
      VALUES ('#{username}', '#{email}', '#{password}')
      RETURNING id, username, email;
      ")
    User.new(id: result[0]['id'], username: result[0]['username'], email: result[0]['email'])
  end

  attr_reader :id, :email, :username

  def initialize(id:, email:, username:)
    @id = id
    @email = email
    @username = username
  end
end
