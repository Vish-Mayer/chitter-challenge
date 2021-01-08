
require 'comment'

describe Comment do

  let(:reply_class) { double(:reply_class) }

  describe '.create' do
    it 'creates a new comment' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'This is a test comment', peep_id: peep.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq data_matcher('id', 'comments').first
      expect(comment.text).to eq 'This is a test comment'
      expect(comment.peep_id).to eq peep.id
    end
  end

  describe '.where' do
    it 'creates a new comment' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'This is a test comment', peep_id: peep.id)

      where = Comment.where(peep_id: peep.id)

      expect(peep.id).to eq where[0].peep_id

    end
  end

  describe '.count' do
    it 'returns the amount of comments made in a peep' do
      peep = Peep.create(body: 'this is a test peep')
      Comment.create(text: 'This is a test comment', peep_id: peep.id)
      Comment.create(text: 'This is another test comment', peep_id: peep.id)

      count = Comment.count(peep_id: peep.id)

      expect(count).to eq '2'

    end
  end

  describe '#replies' do
    it 'calls .count on the comment class' do
      peep = Peep.create(body: 'this is a test peep')
      comment = Comment.create(text: 'This is a test comment', peep_id: peep.id)
      expect(reply_class).to receive(:where).with(comment_id: comment.id)
      comment.replies(reply_class)
    end
  end
end
