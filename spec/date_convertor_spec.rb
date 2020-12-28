require 'data_convertor'

describe Convert do

  describe '.date' do
    it 'returns "today" if date is eq to current date' do
      expect(Convert.date(Time.now.strftime("%Y-%m-%d"))).to eq 'today'
    end

    it 'returns "yesterday" if (current date - date) is eq to 1' do
      expect(Convert.date('2020-12-27', DateTime.new(2020,12,28))).to eq 'yesterday'
    end

    it 'returns "..days go" if (current date - date) is above 1' do
      expect(Convert.date('2020-12-26', DateTime.new(2020,12,28))).to eq '2 days ago'
    end
  end
end
