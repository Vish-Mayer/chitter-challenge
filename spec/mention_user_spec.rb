require 'mention_user'

describe MentionUser do

  describe '.create' do

    it 'creates a new mentioned user record' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user2 = User.create(username: 'mentioned_user', email: 'mentioned@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test mention @tagged_user')
      mention = MentionUser.create(peep_id: peep.id, user_id: user.id, mentioned_user: user2.username)

      expect(peep.id).to eq data_matcher('peep_id', 'mention_user').first
      expect(mention.user_id).to eq user.id
      expect(mention.mentioned_user_id).to eq user2.id
    end

    it "does not create a mention if the gathered @mention does not exist" do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user2 = User.create(username: 'mentioned_user', email: 'mentioned@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test mention @non-existing-user')
      mention = MentionUser.create(peep_id: peep.id, user_id: user.id, mentioned_user: '@non-existing-user')

      expect(mention).to eq nil
    end
  end
end
