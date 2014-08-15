# steamgrid
#   Alex Standke
#   https://github.com/XanderStrike/steamgrid
#   MIT License
#
# Simple app for showing a pretty grid of your steam games.

require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/grid' do
  begin
    @name = params[:id]
    steamid = Nokogiri::HTML(open("http://steamcommunity.com/id/#{ params[:id] }?xml=1")).css("//profile//steamid64").children
    @games = JSON.parse(open("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E1FF6953510EF124ADA4C4E68A11BC35&steamid=#{ steamid }&format=json").read)["response"]["games"]
  rescue
    @notfound = true
  end

  erb :grid
end

get '/public/:filename' do
  send_file File.expand_path(params[:filename], settings.public_folder)
end
