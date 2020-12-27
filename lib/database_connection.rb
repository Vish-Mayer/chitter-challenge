# # frozen_string_literal: true
require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end
  #
  class << self
    attr_reader :connection
  end

  if ENV['RACK_ENV'] == 'test'
    DatabaseConnection.setup('chitter_test')
    p "this is a test"
  else
    DatabaseConnection.setup('chitter')
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
