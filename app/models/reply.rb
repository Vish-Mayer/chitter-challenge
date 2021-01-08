# frozen_string_literal: true

class Reply

  def self.create(text:, comment_id:)
    result = DatabaseConnection.query("INSERT INTO replies (text, comment_id) VALUES('#{text}', '#{comment_id}') RETURNING id, text, comment_id;")
    Reply.new(id: result[0]['id'], text: result[0]['text'], comment_id: result[0]['comment_id'])
  end

  def self.where(comment_id:)
    result = DatabaseConnection.query("
      SELECT *
      FROM replies
      WHERE comment_id = '#{comment_id}'
      ORDER by replies.id DESC
      ")
    result.map { |reply| Reply.new(id: reply['id'], text: reply['text'], comment_id: reply['comment_id']) }
  end

  attr_reader :id, :text, :comment_id

  def initialize(id:, text:, comment_id:)
    @id = id
    @text = text
    @comment_id = comment_id
  end

  # def users(user_class = User)
  #   user_class.comments(comment_id: id)
  # end
end
