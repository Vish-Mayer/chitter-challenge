require 'hashtag'

describe HashTag do

  let(:peep_class) { double(:peep_class) }
  subject(:hashtag) { described_class.create(hashtag: "#hashtag")}

  describe '.scan' do

    it 'scans through the given string to identify a hashtag' do
      hashtags = []
      hashtag = HashTag.scan(body: "Im a #hashtag #dude")
      hashtag.map { |hashtag| hashtags << hashtag }

      expect(hashtags[0].content).to eq "#hashtag"
      expect(hashtags[1].content).to eq "#dude"
    end
  end

  describe '.create' do

    it 'adds a hashtag to the hashtags table' do
      expect(hashtag.id).to eq data_matcher('id', 'hashtags').first
      expect(hashtag.content).to eq data_matcher('content', 'hashtags').first
    end

    it 'uses an existing hashtag when it exists in the hashtag table' do
      hashtag2 = HashTag.create(hashtag: "#hashtag")
      expect(hashtag.id).to eq hashtag2.id
    end
  end

  describe '.where' do
    it 'it finds the hashtag on the given peep id' do
      peep = Peep.create(body: 'this is a test peep')
      hashtag_peep = HashTagPeep.create(hashtag_id: hashtag.id, peep_id: peep.id)

      expect(hashtag.id).to eq hashtag_peep.hashtag_id
      expect(peep.id).to eq hashtag_peep.peep_id
    end
  end

  describe '#peeps' do
    it 'calls .where on the user class' do
      expect(peep_class).to receive(:where).with(hashtag_id: hashtag.id)
      hashtag.peeps(peep_class)
    end
  end
end
