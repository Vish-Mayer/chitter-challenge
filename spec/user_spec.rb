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
end
