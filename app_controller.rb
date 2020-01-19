require 'sinatra/base'
require './lib/peeps'
require 'pg'

class Chitter < Sinatra::Base

  enable :sessions

  get '/' do
    redirect '/sign_in'
  end

  get '/sign_in' do
    erb :sign_in 
  end

  get '/homepage' do
    @peeps = Peeps.all 
    erb :homepage 
  end

  post '/homepage' do
    Peeps.create(params[:message])
    redirect '/homepage'
  end

    

  run! if app_file == $0
end
