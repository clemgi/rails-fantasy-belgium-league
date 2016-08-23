require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'

url_string = "http://sporza.be/cm/sporza/matchcenter/mc_voetbal/JupilerProLeague1617"

index_page = Nokogiri::HTML(open(url_string))

teams_hash = {}

team_css = index_page.css('tbody > tr').each do |team_row|
  team_name = team_row.css('.team').children.first.children.text
  team_url = team_row.css('.team').children.first.attributes["href"].value
  games_played = team_row.css('td:nth-child(3)').children.first.text
  wins = team_row.css('td:nth-child(4)').children.first.text
  losses = team_row.css('td:nth-child(5)').children.first.text
  draws = team_row.css('td:nth-child(6)').children.first.text
  gf = team_row.css('td:nth-child(7)').children.first.text
  ga = team_row.css('td:nth-child(8)').children.first.text
  gd = team_row.css('td:nth-child(9)').children.first.text
  points = team_row.css('td:nth-child(10)').children.first.text

  teams_hash[team_name] = {}
  teams_hash[team_name][:team_url] = team_url
  teams_hash[team_name][:won] = wins
  teams_hash[team_name][:lost] = losses
  teams_hash[team_name][:draw] = draws
  teams_hash[team_name][:gf] = gf
  teams_hash[team_name][:ga] = ga
  teams_hash[team_name][:gd] = gd
  teams_hash[team_name][:points] = points


  team_show_view = Nokogiri::HTML(open("http://sporza.be#{team_url}"))

  players_list = team_show_view.css('tbody').each do |player_row|

    
  end





  json = File.read('player-list.json')

  File.open('player-list.json', 'w') do |file|
    file.write(JSON.pretty_generate(JSON.parse(json).merge teams_hash))
  end

  # binding.pry
end

puts 'whaddup'