require 'peeps'

describe Peeps do
  describe '.all' do

    it 'returns a list of peeps' do
      expect(Peeps.all).to include "A bunch of Peeps"
      
      
    end
  end
end