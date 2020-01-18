require 'sinatra/base'

class Chitter < Sinatra::Base

  get '/' do
    redirect '/sign_in'
  end

  get '/sign_in' do
    erb :sign_in 
  end

  get '/homepage' do 
    erb :homepage 
  end 
    

  run! if app_file == $0
end
