require 'user'
require 'data_matcher'
require 'bcrypt'

describe User do

  describe '.all' do
    it 'returns a list of all of the registered users' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user = User.all
      expect(user.first.username).to eq('test_username')
    end
  end

  describe '.create' do

    it 'creates a new user' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')

      expect(user.id).to eq data_matcher('id', 'users').first
      expect(user.username).to eq 'test_username'
      expect(user.email).to eq 'test@testmail.com'
    end

    it 'hashes out the password using Bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
    end
  end

  describe '.authenticate' do

    it 'retrives an existing user from the data base' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@testmail.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end
  end

  describe '.find' do
    it 'it finds the user on the given id' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      result = User.find(id: user.id)

      expect(user).to be_a User
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end

  describe '.where' do
    it 'it finds the user on the given peep id' do
      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test peep')
      user_peep = UserPeep.create(user_id: user.id, peep_id: peep.id)

      expect(user.id).to eq user_peep.user_id
      expect(peep.id).to eq user_peep.peep_id
    end
  end
end
