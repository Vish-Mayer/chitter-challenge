# frozen_string_literal: true

def setup_test_database
  require 'pg'

  p 'Setting up test database...'

  connection = PG.connect(dbname: 'chitter_test')

  # Clear the bookmarks table
  connection.exec('TRUNCATE users, peeps, user_peeps;')
end
