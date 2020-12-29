class HashTag

  @hashtags = nil

  def self.scan(body:)
    result = body.to_enum(:scan, /(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i ).map { Regexp.last_match }
    result.join.split(" ").map { |hashtag| HashTag.create(hashtag: hashtag) }
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

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM hashtags WHERE id = #{id}")
    HashTag.new(id: result[0]['id'], content: result[0]['content'])
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
    result = search.map { |all| all }
    result.map { |hashtag| HashTag.new(id: hashtag['hashtag_id'], content: hashtag['content'],)}
  end

  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def peeps(peep_class = Peep)
    peep_class.where(hashtag_id: id)
  end
end
