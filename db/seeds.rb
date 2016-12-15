
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


user1 = User.create(
  nickname: "iLarry",
  email: "larry@msn.com",
  first_name: "Larry",
  last_name: "Grutman",
  password: "123456"
  )
user2 = User.create(
  nickname: "Clemmy",
  email: "clemy@mcaramail.com",
  first_name: "Clemence",
  last_name: "Gillion",
  password: "123456"
  )

user3 = User.create(
  nickname: "Tuds",
  email: "Tudsy@gmail.com",
  first_name: "Tudsy",
  last_name: "Willy",
  password: "123456"
  )

user4 = User.create(
  nickname: "Diane",
  email: "Anne@gmail.com",
  first_name: "Anne",
  last_name: "Collet",
  password: "123456"
  )

league1 = League.create(
  name: "Générale"
  )

league2 = League.create(
  name: "Les p'tits potes"
  )

league1.users << user1
league1.users << user2
league1.users << user3
league1.users << user4

squad1 = Squad.create(
  name: "Mon équipe de choc",
  budget: 100,
  total_points: 0,
  user_id: user1.id
  )

squad2 = Squad.create(
  name: "Les mousquetaires",
  budget: 100,
  total_points: 0,
  user_id: user2.id
  )

squad3 = Squad.create(
  name: "The Devils",
  budget: 100,
  total_points: 0,
  user_id: user3.id
  )

squad4 = Squad.create(
  name: "Le Wagon XI",
  budget: 100,
  total_points: 0,
  user_id: user4.id
  )


