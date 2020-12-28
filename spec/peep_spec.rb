require 'peep'

describe Peep do

  let(:user_class) { double(:user_class) }
  let(:convert_date_class) { double(:convert_date_class) }

  describe '.all' do
    it 'returns all of the peeps' do
      Peep.create(body: 'this is a test peep')
      peeps = Peep.all
      expect(peeps.first.body).to eq('this is a test peep')
    end

    it 'returns all of the peeps in reverse chronological order' do
      peep1 = Peep.create(body: 'this is a test peep')
      peep2 = Peep.create(body: 'this is a newer peep')
      peep = Peep.all
      expect(peep.first.body).to eq('this is a newer peep')
    end
  end

  describe '.create' do
    it 'creates a new peep' do
      peep = Peep.create(body: 'this is a test peep')
      expect(peep.id).to eq data_matcher('id', 'peeps').first
      expect(peep.body).to eq data_matcher('body', 'peeps').first
      expect(peep.date).to eq Time.now.strftime("%Y-%m-%d")
    end
  end

  describe '#user' do
    it 'calls .where on the user class' do
      peep = Peep.create(body: 'test peep')
      expect(user_class).to receive(:where).with(peep_id: peep.id)
      peep.user(user_class)
    end
  end

  describe '#created_at' do
    it 'calls .where on the convert date class' do
      peep = Peep.create(body: 'test peep')
      expect(convert_date_class).to receive(:where).with(date: peep.date)
      peep.created_at(convert_date_class)
    end
  end
end
