class UserActivity

  def self.create(type:, peep_id:, user_1_id:, user_2_id:)

    result = DatabaseConnection.query(
      "INSERT
      INTO user_activity (type, peep_id, user_1_id, user_2_id)
      VALUES('#{type}', '#{peep_id}', '#{user_1_id}', '#{user_2_id}')
      RETURNING id, type, peep_id, user_1_id, user_2_id;"
    )
    UserActivity.new(
      id: result[0]['id'],
      type: result[0]['type'],
      user_1_id: result[0]['user_1_id'],
      user_2_id: result[0]['user_2_id'],
      peep_id: result[0]['peep_id'],
    )
  end

  attr_reader :id, :type, :peep_id, :user_1_id, :user_2_id

  def initialize(id:, type:, peep_id:, user_1_id:, user_2_id:)
    @id = id
    @type = type
    @peep_id = peep_id
    @user_1_id = user_1_id
    @user_2_id = user_2_id
  end
end
