require 'hashtag'

describe HashTag do

  describe '.scan' do

    it 'scans through a given string to create a hashtag' do
      hashtag = HashTag.scan(content: "This is a #hashtag")
      expect(hashtag.content).to eq '#hashtag'
    end
  end

  describe '.create' do

    it 'adds a hashtag to the hashtags table' do
      hashtag = HashTag.create(hashtag: "#hashtag")
      expect(hashtag.id).to eq data_matcher('id', 'hashtags').first
      expect(hashtag.content).to eq data_matcher('content', 'hashtags').first
    end
  end

  describe '.where' do
    it 'it finds the hashtag on the given peep id' do
      peep = Peep.create(body: 'this is a test peep')
      hashtag = HashTag.create(hashtag: "#hashtag")
      hashtag_peep = HashTagPeep.create(hashtag_id: hashtag.id, peep_id: peep.id)

      expect(hashtag.id).to eq hashtag_peep.hashtag_id
      expect(peep.id).to eq hashtag_peep.peep_id
    end
  end
end
