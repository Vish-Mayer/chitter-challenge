# frozen_string_literal: true

def setup_test_database

  p 'Setting up test database...'

  connection = PG.connect(dbname: 'chitter_test')

  # Clear the chitter tables
  connection.exec('
    TRUNCATE users, peeps, comments, hashtags, user_peep, user_comment, hashtag_peep, user_activity;
    ')
end
