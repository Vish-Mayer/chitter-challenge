require 'user_activity'

describe UserActivity do

  describe '.create' do

    it 'creates a new user activity record' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user2 = User.create(username: 'tagger', email: 'tagger@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test peep')
      peep2 = Peep.create(body: 'this is a newer test peep @test_username')
      UserPeep.create(user_id: user.id, peep_id: peep.id)
      UserPeep.create(user_id: user.id, peep_id: peep2.id)
      UserActivity.create(type: 'tagged', peep_id: peep.id, user_1_id: user2.id, user_2_id: user.id)
      UserActivity.create(type: 'mentioned', peep_id: peep2.id, user_1_id: user2.id, user_2_id: user.id)

      expect(user.id).to eq data_matcher('user_2_id', 'user_activity').first
      expect(user2.id).to eq data_matcher('user_1_id', 'user_activity').first
      expect(peep.id).to eq data_matcher('peep_id', 'user_activity').first
      expect(data_matcher('type', 'user_activity').first).to eq 'tagged'

      expect(user.id).to eq data_matcher('user_2_id', 'user_activity').last
      expect(user2.id).to eq data_matcher('user_1_id', 'user_activity').last
      expect(peep2.id).to eq data_matcher('peep_id', 'user_activity').last
      expect(data_matcher('type', 'user_activity').last).to eq 'mentioned'
    end
  end
end
