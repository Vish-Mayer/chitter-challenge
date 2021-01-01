class TagUser

  def self.create(peep_id:, user_id:, tagged_user_id:)
    result = DatabaseConnection.query(
      "INSERT
      INTO tag_user (peep_id, user_id, tagged_user_id)
      VALUES('#{peep_id}', '#{user_id}', '#{tagged_user_id}')
      RETURNING peep_id, user_id, tagged_user_id;"
    )
    TagUser.new(peep_id: result[0]['peep_id'], user_id: result[0]['user_id'], tagged_user_id: result[0]['tagged_user_id'])
  end

  attr_reader :peep_id, :user_id, :tagged_user_id

  def initialize(peep_id:, user_id:, tagged_user_id:)
    @peep_id = peep_id
    @user_id = user_id
    @tagged_user_id = tagged_user_id
  end
end