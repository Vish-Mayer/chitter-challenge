require 'peep'

describe Peep do

  describe '.all' do
    it 'returns all of the peeps' do
      Peep.create(body: 'this is a test peep')
      peep = Peep.all
      expect(peep.first.body).to eq('this is a test peep')
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      peep = Peep.create(body: 'this is a test peep')
      expect(peep.id).to eq data_matcher('id', 'peeps').first
      expect(peep.body).to eq data_matcher('body', 'peeps').first
    end
  end
end
