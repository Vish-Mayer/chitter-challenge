require 'tag_user'

describe TagUser do

  describe '.create' do

    it 'creates a new user peep record' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user2 = User.create(username: 'tagged_user', email: 'tagged@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test peep')
      TagUser.create(peep_id: peep.id, user_id: user.id, tagged_user_id: user2.id)

      expect(peep.id).to eq data_matcher('peep_id', 'tag_user').first
      expect(user.id).to eq data_matcher('user_id', 'tag_user').first
      expect(user2.id).to eq data_matcher('tagged_user_id', 'tag_user').first
    end
  end
end
