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
  @name = params[:id]
  steam_profile_url = URI("https://steamcommunity.com/id/#{ params[:id] }?xml=1")
  steamid = Nokogiri::HTML(URI.open(steam_profile_url)).css("//profile//steamid64").children
  api_url = URI("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E1FF6953510EF124ADA4C4E68A11BC35&steamid=#{ steamid }&format=json")
  @games = JSON.parse(URI.open(api_url).read)["response"]["games"]

  erb :grid
end

get '/public/:filename' do
  send_file File.expand_path(params[:filename], settings.public_folder)
end
