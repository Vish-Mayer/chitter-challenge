# frozen_string_literal: true
$LOAD_PATH << './lib'
$LOAD_PATH << './app/controllers'
$LOAD_PATH << './app/models'

require 'sinatra/base'
require 'sinatra/flash'

require './lib/database_connection'
require './lib/convert_date'
require 'email'

require 'user'
require 'peep'
require 'hashtag'
require 'comment'
require 'reply'
require 'user_peep'
require 'hashtag_peep'
require 'user_comment'
require 'user_reply'
require 'user_activity'

class Chitter < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  enable :sessions
  register Sinatra::Flash

  get('/') do
    erb :index
  end

  get('/peeps') do
    @user = User.find(id: session[:user_id])
    @users = User.all
    @peeps = Peep.all
    @usernames = User.allUsernames
    erb :'peeps/index'
  end

  post('/peep/new') do

    hashtags = HashTag.scan(body: params[:text_area])
    mentioned_users = User.scan(body: params[:text_area])
    peep = Peep.create(body: params[:text_area])

    UserPeep.create(user_id: session[:user_id], peep_id: peep.id)

    hashtags.map { |hashtag|
      HashTagPeep.create(hashtag_id: hashtag.id, peep_id: peep.id)
    }
    mentioned_users.map { |mentioned_user|
      mentioned_user_id = DatabaseConnection.query("SELECT id FROM users WHERE username = '#{mentioned_user}'")
      UserActivity.create(type: 'mentioned', peep_id: peep.id, user_1_id: session[:user_id], user_2_id: mentioned_user_id[0]['id'])
    }
    redirect('/peeps')
  end

  get('/peeps/hashtags/:id') do
    @user = User.find(id: session[:user_id])
    @users = User.all
    @hashtag = HashTag.find(id: params[:id])
    @tag_name = params[:display_tag]
    erb :'hashtags/filter'
  end

  post('/peeps/:id/new_comment') do
    comment = Comment.create(text: params[:comment], peep_id: params[:id])
    UserComment.create(user_id: session[:user_id], comment_id: comment.id)
    redirect('/peeps')
  end

  post('/peeps/:comment_id/reply') do
    reply = Reply.create(text: params[:reply_text], comment_id: params[:comment_id])
    UserReply.create(user_id: session[:user_id], reply_id: reply.id)
    redirect('/peeps')
  end

  post('/peeps/:id/tag_user') do

    if params[:select_user] != "0"
      UserActivity.create(type: 'tagged', peep_id: params[:id], user_1_id: session[:user_id], user_2_id: params[:select_user])
      tagged_user = User.find(id: params[:select_user])
      user = User.find(id: session[:user_id])
      Email.send(tagged_user: tagged_user.email, user: user.username, verb_type: 'tagged')
    else
      flash[:notice] = 'Select a user to tag'
    end
    redirect('/peeps')
  end

  get('/user_page') do
    @user = User.find(id: session[:user_id])
    @users = User.all
    erb :'users/index'
  end

  get('/users/new') do
    erb :'users/new'
  end

  post('/chitter/users') do
    registered_user = User.already_exists?(username: params[:username], email: params[:email])
    if registered_user
      flash[:notice] = 'Username or Email is already being used'
      redirect('/users/new')
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect('/peeps')
    end
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

  post('/sessions/destroy') do
    session.clear
    flash[:notice] = 'Signed out.'
    redirect('/')
  end
end
