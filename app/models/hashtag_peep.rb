class HashTagPeep

  def self.create(hashtag_id:, peep_id:)
    result = DatabaseConnection.query(
      "INSERT
      INTO hashtag_peep (hashtag_id, peep_id)
      VALUES('#{hashtag_id}', '#{peep_id}')
      RETURNING hashtag_id, peep_id;"
    )
    HashTagPeep.new(hashtag_id: result[0]['hashtag_id'], peep_id: result[0]['peep_id'])
  end

  attr_reader :hashtag_id, :peep_id

  def initialize(hashtag_id:, peep_id:)
    @hashtag_id = hashtag_id
    @peep_id = peep_id
  end
end
