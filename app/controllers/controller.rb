# frozen_string_literal: true
$LOAD_PATH << './lib'
$LOAD_PATH << './app/controllers'
$LOAD_PATH << './app/models'

require 'sinatra/base'
require 'sinatra/flash'

require './lib/database_connection'
require './lib/data_convertor'

require 'user'
require 'peep'

class Chitter < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  enable :sessions
  register Sinatra::Flash

  get('/') do
    erb :index
  end

  get('/users/new') do
    erb :'users/new'
  end

  get('/peeps') do
    @user = User.find(id: session[:user_id])
    @peeps = Peep.all
    erb :'peeps/index'
  end

  post('/peep/new') do
    Peep.create(body: params[:text_area])
    redirect('/peeps')
  end

  post('/chitter/users') do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect('/peeps')
  end

  post('/sessions') do
    user = User.authenticate(email: params[:email], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect('/peeps')
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/')
    end
  end
end
