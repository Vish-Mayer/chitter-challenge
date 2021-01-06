class UserComment

  def self.create(user_id:, comment_id:)
    result = DatabaseConnection.query("
      INSERT
      INTO user_comment (user_id, comment_id)
      VALUES('#{user_id}', '#{comment_id}')
      RETURNING user_id, comment_id;
    ")
    UserComment.new(user_id: result[0]['user_id'], comment_id: result[0]['comment_id'])
  end

  attr_reader :user_id, :comment_id

  def initialize(user_id:, comment_id:)
    @user_id = user_id
    @comment_id = comment_id
  end
end
