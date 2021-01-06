# frozen_string_literal: true

class Comment

  def self.create(text:, peep_id:)
    result = DatabaseConnection.query("INSERT INTO comments (text, peep_id) VALUES('#{text}', '#{peep_id}') RETURNING id, text, peep_id;")
    Comment.new(id: result[0]['id'], text: result[0]['text'], peep_id: result[0]['peep_id'])
  end

  def self.where(peep_id:)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE peep_id = '#{peep_id}'")
    result.map { |comment| Comment.new(id: comment['id'], text: comment['text'], peep_id: comment['peep_id']) }
  end

  attr_reader :id, :text, :peep_id

  def initialize(id:, text:, peep_id:)
    @id = id
    @text = text
    @peep_id = peep_id
  end
end
