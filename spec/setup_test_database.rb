# frozen_string_literal: true
require 'pg'

def setup_test_database

  p 'Setting up test database...'

  connection = PG.connect(dbname: 'chitter_test')

  # Clear the chitter tables
  connection.exec('
    TRUNCATE users, peeps, user_peep, hashtags, hashtag_peep, tag_user;
    ')
end
