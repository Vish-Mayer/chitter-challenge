# frozen_string_literal: true
require 'bcrypt'

task default: %w[test_tables]

task :bundle do
  puts 'Installing bundle...'
  sh 'gem install bundler'
end

task gems: [:bundle] do
  puts 'Running bundle...'
  sh 'bundle'
end

task postgresql: [:gems] do
  puts 'Installing postgresql...'
  sh 'brew install postgresql'
end

task database: [:postgresql] do
  puts 'Clearing and creating databases...'
  begin
    sh "dropdb 'chitter'"
  rescue StandardError => e
    puts e
  end
  begin
    sh "createdb 'chitter'"
  rescue StandardError => e
    puts e
  end
  begin
    sh "dropdb 'chitter_test'"
  rescue StandardError => e
    puts e
  end
  begin
    sh "createdb 'chitter_test'"
  rescue StandardError => e
    puts e
  end
end

task development_tables: [:database] do
  puts 'Creating development tables...'
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(60), email VARCHAR(60), password VARCHAR(140));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE peeps(id SERIAL PRIMARY KEY, body VARCHAR, date DATE);"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE hashtags(id SERIAL PRIMARY KEY, content VARCHAR(60));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE replies(id SERIAL PRIMARY KEY, text VARCHAR(240), comment_id INTEGER REFERENCES comments (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE user_peep(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE user_comment(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), comment_id INTEGER REFERENCES comments (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE user_reply(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), reply_id INTEGER REFERENCES replies (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE hashtag_peep(id SERIAL PRIMARY KEY, hashtag_id INTEGER REFERENCES hashtags (id), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE user_activity(id SERIAL PRIMARY KEY, type VARCHAR(60), peep_id INTEGER REFERENCES peeps (id), user_1_id INTEGER REFERENCES users (id), user_2_id INTEGER REFERENCES users (id));"]
end

task development_tables: [:database] do
  puts 'Adding development data...'
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO users (username, email, password) VALUES ('username123', 'test@testmail.com', 'password123');"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO peeps (body, date) VALUES ('test peep!', '2020-10-10');"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO hashtags (content) VALUES ('#chitter');"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO comments (text, peep_id) VALUES ('test comment!', 1);"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO user_peep (user_id, peep_id) VALUES (1, 1);"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO user_comment (user_id, comment_id) VALUES (1, 1);"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO hashtag_peep (hashtag_id, peep_id) VALUES (1, 1);"]
end

task test_tables: [:development_tables] do
  puts 'Creating test tables...'
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(60), email VARCHAR(60), password VARCHAR(140));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE peeps(id SERIAL PRIMARY KEY, body VARCHAR, date DATE);"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE hashtags(id SERIAL PRIMARY KEY, content VARCHAR(60));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE replies(id SERIAL PRIMARY KEY, text VARCHAR(240), comment_id INTEGER REFERENCES comments (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE user_peep(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE user_comment(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), comment_id INTEGER REFERENCES comments (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE user_reply(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), reply_id INTEGER REFERENCES replies (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE hashtag_peep(id SERIAL PRIMARY KEY, hashtag_id INTEGER REFERENCES hashtags (id), peep_id INTEGER REFERENCES peeps (id));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE user_activity(id SERIAL PRIMARY KEY, type VARCHAR(60), peep_id INTEGER REFERENCES peeps (id), user_1_id INTEGER REFERENCES users (id), user_2_id INTEGER REFERENCES users (id));"]
end
