class UserReply

  def self.create(user_id:, reply_id:)
    result = DatabaseConnection.query("
      INSERT
      INTO user_reply (user_id, reply_id)
      VALUES('#{user_id}', '#{reply_id}')
      RETURNING user_id, reply_id;
    ")
    UserReply.new(user_id: result[0]['user_id'], reply_id: result[0]['reply_id'])
  end

  attr_reader :user_id, :reply_id

  def initialize(user_id:, reply_id:)
    @user_id = user_id
    @reply_id = reply_id
  end
end
