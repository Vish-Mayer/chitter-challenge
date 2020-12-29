require 'convert_date'

describe ConvertDate do

  describe '.date' do
    it 'returns "today" if date is eq to current date' do
      expect(ConvertDate.where(date: Time.now.strftime("%Y-%m-%d"))).to eq 'today'
    end

    it 'returns "yesterday" if (current date - date) is eq to 1' do
      expect(ConvertDate.where(date: '2020-12-27', current_date: DateTime.new(2020, 12, 28))).to eq 'yesterday'
    end

    it 'returns "..days go" if (current date - date) is above 1' do
      expect(ConvertDate.where(date: '2020-12-26', current_date: DateTime.new(2020, 12, 28))).to eq '2 days ago'
    end
  end
end
