# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'user'

class Chitter < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  enable :sessions

  get('/') do
    erb :index
  end

  get('/users/new') do
    erb :'users/new'
  end

  get('/peeps') do
    @username = session[:username]
    erb :'peeps/index'
  end

  post('/chitter/users') do
    User.create(username: params[:username], email: params[:email], password: params[:password])
    # "INSERT INTO users (username, email, password) VALUES ('#{params[:username]}', '#{params[:email]}', '#{params[:password]}')"
    session[:username] = params[:username]
    redirect('/peeps')
  end
end
