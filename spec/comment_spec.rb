
require 'comment'

describe Comment do

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
end
