require 'peeps'

describe Peeps do
  describe '.all' do

    it 'returns a list of peeps' do
      connection = PG.connect(dbname: 'peep_manager_test')
      connection.exec("INSERT INTO peeps (peep) VALUES ('Test Tweet');")
      

      expect(Peeps.all).to include "Test Tweet"
      
      
    end
  end
end