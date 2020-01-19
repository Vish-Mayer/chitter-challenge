require 'sinatra/base'
require './lib/peeps'

class Chitter < Sinatra::Base

  enable :sessions

  get '/' do
    redirect '/sign_in'
  end

  get '/sign_in' do
    erb :sign_in 
  end

  get '/homepage' do
    p ENV
    @peeps = Peeps.all 
    erb :homepage 
  end 
    

  run! if app_file == $0
end
