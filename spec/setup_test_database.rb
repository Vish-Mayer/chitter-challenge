# frozen_string_literal: true

def setup_test_database

  p 'Setting up test database...'

  connection = PG.connect(dbname: 'chitter_test')

  # Clear the chitter tables
  connection.exec('
    TRUNCATE users, peeps, user_peep, hashtags, hashtag_peep, tag_user, mention_user;
    ')
end
