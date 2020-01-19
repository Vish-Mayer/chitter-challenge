require 'pg'

class Peeps

  def self.all
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'peep_manager_test')
    else
      connection = PG.connect(dbname: 'peep_manager')
    end 

    result = connection.exec('SELECT * FROM peeps')
    result.map { |peep| peep['peep'] }
    
  end
end 