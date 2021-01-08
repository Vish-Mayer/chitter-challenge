require 'user_reply'

describe UserReply do

  describe '.create' do

    let(:user_class) { double(:user_class) }
    let(:user) { User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123') }
    let(:peep) { Peep.create(body: 'this is a test peep') }
    let(:comment) { Comment.create(text: 'test comment', peep_id: peep.id) }



    it 'creates a new user reply record' do
      reply = Reply.create(text: 'test reply', comment_id: comment.id)
      user_reply = UserReply.create(user_id: user.id, reply_id: reply.id )

      expect(user.id).to eq data_matcher('user_id', 'user_reply').first
      expect(reply.id).to eq data_matcher('reply_id', 'user_reply').first
    end

  end
end
