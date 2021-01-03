class MentionUser

  def self.create(peep_id:, user_id:, mentioned_user:)

    mentioned_user_id = DatabaseConnection.query("SELECT id FROM users WHERE username = '#{mentioned_user}'")
    if mentioned_user_id.any?
      result = DatabaseConnection.query("
        INSERT
        INTO mention_user (peep_id, user_id, mentioned_user_id)
        VALUES('#{peep_id}', '#{user_id}', '#{mentioned_user_id[0]['id']}')
        RETURNING peep_id, user_id, mentioned_user_id;
      ")
      MentionUser.new(peep_id: result[0]['peep_id'], user_id: result[0]['user_id'], mentioned_user_id: result[0]['mentioned_user_id'])
    else
      nil
    end
  end

  attr_reader :peep_id, :user_id, :mentioned_user_id

  def initialize(peep_id:, user_id:, mentioned_user_id:)
    @peep_id = peep_id
    @user_id = user_id
    @mentioned_user_id = mentioned_user_id
  end
end
