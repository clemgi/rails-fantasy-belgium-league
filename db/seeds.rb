# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Player.delete_all
Team.delete_all

data_file = File.read(Rails.root.join('db', 'player-list.json'))

teams = JSON.parse(data_file)

teams.each do |key, val|
  t = Team.create!(
    name: key,
    played: val['played'],
    won: val['won'],
    draw: val['draw'],
    lost: val['lost'],
    gf: val['gf'],
    ga: val['ga'],
    gd: val['gd'],
    points: val['points'])

  val['players'].each do |player|
    Player.create!(
      name: player['name'],
      position: player['position'],
      total_points: player['total_points'],
      price: player['price'],
      team_id: t.id)
  end
end





