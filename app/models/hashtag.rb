class HashTag

  @hashtag = nil

  def self.scan(content:)
    content.split(" ").map { |word|
      if word[0] == "#"
        @hashtag = word
      end
     }
     HashTag.create(hashtag: @hashtag)
  end

  def self.create(hashtag:)
    result = DatabaseConnection.query("
      SELECT *
      FROM hashtags WHERE
      content = '#{hashtag}'
      ").first

    if !result
      result = DatabaseConnection.query("
      INSERT
      INTO hashtags (content)
      VALUES('#{hashtag}')
      RETURNING id, content;
      ").first
    end
    HashTag.new(id: result['id'], content: result['content'])
  end

  def self.where(peep_id:)
    search = DatabaseConnection.query("
      SELECT hashtag_id, content
      FROM hashtag_peep as HP
      INNER JOIN
      hashtags as HT
      ON HP.hashtag_id = HT.id
      WHERE peep_id = #{peep_id}
      ")
    result = search.map { |all| p all }
    result.map { |hashtag| HashTag.new(id: hashtag['hashtag_id'], content: hashtag['content'],)}
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end
end
