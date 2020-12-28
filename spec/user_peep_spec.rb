require 'user_peep'

describe UserPeep do

  describe '.create' do

    it 'creates a new user peep record' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test peep')
      UserPeep.create(user_id: user.id, peep_id: peep.id)

      expect(user.id).to eq data_matcher('user_id', 'user_peep').first
      expect(peep.id).to eq data_matcher('peep_id', 'user_peep').first
    end
  end
end
