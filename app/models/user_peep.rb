class UserPeep

  def self.create(user_id:, peep_id:)
    result = DatabaseConnection.query(
      "INSERT
      INTO user_peep (user_id, peep_id)
      VALUES('#{user_id}', '#{peep_id}')
      RETURNING user_id, peep_id;"
    )
    UserPeep.new(user_id: result[0]['user_id'], peep_id: result[0]['peep_id'])
  end

  attr_reader :user_id, :peep_id

  def initialize(user_id:, peep_id:)
    @user_id = user_id
    @peep_id = peep_id
  end
end
