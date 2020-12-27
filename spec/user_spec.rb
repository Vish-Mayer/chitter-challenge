require 'user'
require 'data_matcher'

describe User do

  describe '.create' do

    it 'creates a new user' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')

      expect(user.id).to eq data_matcher('id', 'users').first
      expect(user.username).to eq 'test_username'
      expect(user.email).to eq 'test@testmail.com'

    end
  end

end
