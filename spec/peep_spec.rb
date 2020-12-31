require 'peep'

describe Peep do

  let(:user_class) { double(:user_class) }
  let(:hashtag_class) { double(:hashtag_class) }
  let(:convert_date_class) { double(:convert_date_class) }
  subject(:peep) { Peep.create(body: 'this is a test peep') }

  describe '.all' do
    it 'returns all of the peeps' do
      peep = Peep.create(body: 'this is a test peep')
      peeps = Peep.all
      expect(peeps.first.body).to eq('this is a test peep')
    end

    it 'returns all of the peeps in reverse chronological order' do

      peep2 = Peep.create(body: 'this is a newer peep')
      peep = Peep.all

      expect(peep.first.body).to eq('this is a newer peep')
    end
  end

  describe '.create' do

    it 'creates a new peep' do
      expect(peep.id).to eq data_matcher('id', 'peeps').first
      expect(peep.body).to eq data_matcher('body', 'peeps').first
      expect(peep.date).to eq Time.now.strftime("%Y-%m-%d")
    end
  end

  describe '.where' do

    it 'it finds the peeps with a given hashtag id' do

      hashtag = HashTag.create(hashtag: "#hashtag")
      hashtag_peep = HashTagPeep.create(hashtag_id: hashtag.id, peep_id: peep.id)

      expect(hashtag.id).to eq hashtag_peep.hashtag_id
      expect(peep.id).to eq hashtag_peep.peep_id
    end

    it 'returns filtered peeps filtered by a hashtag in reverse chronological order' do

      hashtag = HashTag.create(hashtag: "#hashtag")
      hashtag_peep1 = HashTagPeep.create(hashtag_id: hashtag.id, peep_id: peep.id)

      peep2 = Peep.create(body: 'this is a newer test peep')
      hashtag2 = HashTag.create(hashtag: "#hashtag")
      hashtag_peep2 = HashTagPeep.create(hashtag_id: hashtag2.id, peep_id: peep2.id)

      peep = Peep.where(hashtag_id: hashtag.id)

      expect(peep.first.body).to eq('this is a newer test peep')
    end
  end

  describe '.users' do

    it 'it finds the peeps with a given user id' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user_peep = UserPeep.create(user_id: user.id, peep_id: peep.id)

      expect(user.id).to eq user_peep.user_id
      expect(peep.id).to eq user_peep.peep_id
    end

    it 'returns filtered peeps filtered by a hashtag in reverse chronological order' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user_peep = UserPeep.create(user_id: user.id, peep_id: peep.id)
      peep2 = Peep.create(body: 'this is a newer test peep')
      user_peep = UserPeep.create(user_id: user.id, peep_id: peep2.id)
      peeps = Peep.users(user_id: user.id)

      expect(peeps.first.body).to eq('this is a newer test peep')
    end
  end

  describe '.tagged_users' do

    it 'it finds a tagged peep with a given tagged_user id - returns in reverse chronological order' do

      user = User.create(username: 'test_username', email: 'test@testmail.com', password: 'password123')
      user2 = User.create(username: 'tagger', email: 'tagger@testmail.com', password: 'password123')
      peep = Peep.create(body: 'this is a test peep')
      peep2 = Peep.create(body: 'this is a newer test peep')
      UserPeep.create(user_id: user.id, peep_id: peep.id)
      UserPeep.create(user_id: user.id, peep_id: peep2.id)
      TagUser.create(peep_id: peep.id, user_id: user2.id, tagged_user_id: user.id)
      TagUser.create(peep_id: peep2.id, user_id: user2.id, tagged_user_id: user.id)
      tagged_peep = Peep.tagged_users(tagged_user_id: user.id)

      expect(tagged_peep[0].last).to eq tagged_by: user2.username
      expect(tagged_peep[0].first.id).to eq peep2.id
      expect(tagged_peep[0].first.body).to eq peep2.body
    end
  end

  describe '#user' do
    it 'calls .where on the user class' do

      expect(user_class).to receive(:where).with(peep_id: peep.id)
      peep.user(user_class)
    end
  end

  describe '#hashtag' do
    it 'calls .where on the hashtag class' do

      expect(hashtag_class).to receive(:where).with(peep_id: peep.id)
      peep.user(hashtag_class)
    end
  end

  describe '#created_at' do

    it 'calls .where on the convert date class' do

      expect(convert_date_class).to receive(:where).with(date: peep.date)
      peep.created_at(convert_date_class)
    end
  end
end
