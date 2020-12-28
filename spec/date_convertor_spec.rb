require 'data_convertor'

describe Convert do

  describe '.date' do
    it 'converts todays date to the word today' do
      expect(Convert.date(Time.now.strftime("%Y-%m-%d"))).to eq 'today'
    end

    # it 'converts todays date to the word today' do
    #   expect(Convert.date('2015-10-2')).to eq 'today'
    # end
  end
end
