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
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE peeps(id SERIAL PRIMARY KEY, text VARCHAR, date DATE);"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="CREATE TABLE user_peeps(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), peep_id INTEGER REFERENCES peeps (id));"]
end

task development_tables: [:database] do
  puts 'Adding development data...'
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO users (username, email, password) VALUES ('username123', 'test@testmail.com', 'password123');"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO peeps (text, date) VALUES ('test comment', '2020-10-10');"]
  sh %[psql -U #{ENV['USER']} -d chitter --command="INSERT INTO user_peeps (user_id, peep_id) VALUES (1, 1);"]
end

task test_tables: [:development_tables] do
  puts 'Creating test tables...'
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE users(id SERIAL PRIMARY KEY, username VARCHAR(60), email VARCHAR(60), password VARCHAR(140));"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE peeps(id SERIAL PRIMARY KEY, peep VARCHAR, date DATE);"]
  sh %[psql -U #{ENV['USER']} -d chitter_test --command="CREATE TABLE user_peeps(id SERIAL PRIMARY KEY, user_id INTEGER REFERENCES users (id), peep_id INTEGER REFERENCES peeps (id));"]
end
