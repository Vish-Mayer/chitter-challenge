require 'hashtag_peep'

describe HashTagPeep do

  describe '.create' do

    it 'creates a new hashtag peep record' do

      peep = Peep.create(body: 'this is a test peep')
      hashtag = HashTag.create(hashtag: '#hashtag')
      HashTagPeep.create(hashtag_id: hashtag.id , peep_id: peep.id)

      expect(hashtag.id).to eq data_matcher('hashtag_id', 'hashtag_peep').first
      expect(peep.id).to eq data_matcher('peep_id', 'hashtag_peep').first
    end
  end
end
