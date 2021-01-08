
require 'reply'

describe Reply do

  let(:user_class) { double(:user_class) }

  describe '.create' do
    it 'creates a new reply instance' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'test comment', peep_id: peep.id)
      reply = Reply.create(text: 'test reply', comment_id: comment.id)


      expect(reply.id).to eq data_matcher('id', 'replies').first
      expect(reply.text).to eq 'test reply'
      expect(reply.comment_id).to eq comment.id
    end
  end

  describe '.where' do
    it 'finds a reply based on the comment id' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'test comment', peep_id: peep.id)
      reply = Reply.create(text: 'test reply', comment_id: comment.id)
      where = Reply.where(comment_id: comment.id)

      expect(where.first.id).to eq reply.id
      expect(where.first.text).to eq reply.text
      expect(where.first.comment_id).to eq comment.id
    end
  end

  describe '#users' do
    it 'calls .replies on the user class' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'This is a test comment', peep_id: peep.id)
      reply = Reply.create(text: 'test reply', comment_id: comment.id)

      expect(user_class).to receive(:replies).with(reply_id: reply.id)
      reply.users(user_class)
    end
  end
end
