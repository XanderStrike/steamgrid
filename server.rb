# http://steamcommunity.com/id/xanderstrike?xml=1
#
# http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E1FF6953510EF124ADA4C4E68A11BC35&steamid=76561197978745758&format=json

require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'

set :bind, '0.0.0.0'

get '/' do
  'hello'
end

get '/grid/:id' do
  steamid = Nokogiri::HTML(open("http://steamcommunity.com/id/#{ params[:id] }?xml=1")).css("//profile//steamid64").children

  games = JSON.parse(open("http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=E1FF6953510EF124ADA4C4E68A11BC35&steamid=#{ steamid }&format=json").read)["response"]["games"]

  html = games.map {|g| "<img onerror='this.style.display=\"none\"' width='200px' src='http://cdn4.steampowered.com/v/gfx/apps/#{g["appid"]}/header.jpg' />"}

  return html
end
