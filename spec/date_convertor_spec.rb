require 'data_convertor'

describe Convert do

  describe '.date' do
    it 'returns "today" if date is eq to current date' do
      expect(Convert.date(Time.now.strftime("%Y-%m-%d"))).to eq 'today'
    end

    # it 'returns "yesterday" if (current date - date) is eq to 1' do
    #   expect(Convert.date('2020-10-10')).to eq 'today'
    # end
  end
end
