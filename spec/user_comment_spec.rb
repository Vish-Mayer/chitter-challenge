require 'user_comment'

describe UserComment do

  describe '.create' do

    let(:user_class) { double(:user_class) }
    let(:user) { User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123') }
    let(:peep) { Peep.create(body: 'this is a test peep') }
    let(:comment) { Comment.create(text: 'test comment', peep_id: peep.id) }

    it 'creates a new user comment record' do

      user_comment = UserComment.create(user_id: user.id, comment_id: comment.id)

      expect(user.id).to eq data_matcher('user_id', 'user_comment').first
      expect(comment.id).to eq data_matcher('comment_id', 'user_comment').first
    end

    describe '#users' do
      it 'calls .comments on the user class' do

      expect(user_class).to receive(:users).with(user_id: user.id)
      user.peeps(user_class)
      end
    end
  end
end
