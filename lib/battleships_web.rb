require_relative "game"

require 'sinatra'

set :views, Proc.new {File.join(root, '..', "views")}
set :public, Proc.new {File.join(root, '..', "public")}

enable :sessions

get '/login' do
	redirect '/'
end

get '/' do
	session[:game]= create_game
	session[:num_of_players] = 0
	session[:num_of_players] == 0
	session[:player_one] = ""
	session[:player_two] = ""
	session[:player_one_ships] = ""
	session[:player_two_ships] = ""
	session[:current_player_done] = false
	session[:second_player_done] = false
	session[:game_over] = false
	session[:message]= "Welcome to Battleships!\nClick 'Start' to begin playing"
	erb :index
end

post '/' do
	session[:message]= "Player One\nplease enter your name"
	erb :login
end

post '/login_player_one' do
	session[:player_one] = params[:text]
	if session[:player_one] != ""
		session[:num_of_players] += 1
		set_player_name(player_one, (session[:player_one]).to_s)
		session[:message]= "Player Two\nplease enter your name"
		erb :login
	else
		session[:message]= "Sorry, names can't be blank\nplease try again"
		erb :login
	end
end


post '/login_player_two' do
	session[:player_two]= params[:text]
	if session[:player_two] != session[:player_one] && session[:player_two] != ""
		session[:num_of_players] += 1
		set_player_name(player_two, (session[:player_two]).to_s)
		redirect '/setup'
	elsif session[:player_two] == ""
		session[:message]= "Sorry, names can't be blank\nplease try again"
		erb :login
	else
		session[:message]= "Sorry, players names can't be identical\nplease try again"
		erb :login
	end
end

get '/setup' do
	if session[:num_of_players] == 2
		session[:message]= "Welcome #{session[:player_one]} and #{session[:player_two]}!\nLet's set up the boards"
		erb :login
	else
		redirect '/'
	end
end

post '/setup' do
	redirect '/setup_player_one'
end

get '/setup_player_one' do
	case current_player.ship_count
		when 0
			session[:current_ship] = :battleship
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, Your first ship is a Battleship!\nTo place it on the board, click on 4 consequtive squares and then hit 'Submit'"
			end

		when 1
			session[:current_ship] = :cruiser
			if session[:setup_error] == false
				session[:message] = "Well done, #{current_player.name}! Now let's place a Cruiser (it covers 3 consequtive squares)\nAs before, click on the locations you like and hit 'Submit'"
			end
		when 2
			session[:current_ship] = :cruiser
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, that's awesome!\nNow do the same for your second Cruiser"
			end
		when 3
			session[:current_ship] = :destroyer
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, here come the Destroyers!\nThis time click on 2 consequtive squares to place your first Destroyer and hit 'Submit'"
			end
		when 4
			session[:current_ship] = :destroyer
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, great job!\nNow place your second Destroyer"
			end
		when 5
			session[:current_ship] = :destroyer
			if session[:setup_error] == false
				session[:message] = "That was beautifully done!\nTo comelete the set go ahead and place your third Destroyer"
			end
		when 6
			session[:current_ship] = :submarine
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, we're going underwater!\nTo place your first Submarine select a single square and then hit 'Submit'"
			end
		when 7
			session[:current_ship] = :submarine
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, what an amazing setup!\nPlease choose where to place your second Submarine"
			end
		when 8
			session[:current_ship] = :submarine
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, we're nearly there!\nPlease place your third Submarine"
			end
		when 9
			session[:current_ship] = :submarine
			if session[:setup_error] == false
				session[:message] = "#{current_player.name}, just one more ship to complete your armada!\nPlace your fourth Submarine and you're done!"
			end
	end
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	erb :setup
end

post '/place_ship' do
	if session[:current_player_done] == true
		if current_player == player_one
			session[:current_player_done] = false
			game.switch_turn
			redirect '/setup_player_one'
		else
			game.switch_turn
			redirect '/player_turn'
		end
	else
		coords = params[:coords].split(", ").sort.map { |s| s.to_sym }
		ship = nil
		case session[:current_ship]
			when :battleship
				if coords.count == 4
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinate_3 = Coordinate.new(coords[2])
					coordinate_4 = Coordinate.new(coords[3])
					coordinates = Coordinates.new(coordinate_1, coordinate_2, coordinate_3, coordinate_4)
					if coordinates.valid?
						ship = Battleship.new(coordinates)
					end
				end
			when :cruiser
				if coords.count == 3
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinate_3 = Coordinate.new(coords[2])
					coordinates = Coordinates.new(coordinate_1, coordinate_2, coordinate_3)
					if coordinates.valid?
						ship = Cruiser.new(coordinates)
					end
				end
			when :destroyer
				if coords.count == 2
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinates = Coordinates.new(coordinate_1, coordinate_2)
					if coordinates.valid?
						ship = Destroyer.new(coordinates)
					end
				end
			when :submarine
				if coords.count == 1
					coordinate_1 = Coordinate.new(coords[0])
					coordinates = Coordinates.new(coordinate_1)
					ship = Submarine.new(coordinates)
				end
		end
		if !ship.nil?
			place(ship)
			session[:setup_error] = false
		else
			session[:setup_error] = true
			session[:message] = "Sorry, your #{session[:current_ship]} could not be placed at the selected coordinates\nplease try again"
		end
	end

	if current_player.ship_count < Game::SHIPS_TO_PLACE
		session[:current_player_done] = false
	else
		session[:current_player_done] = true
		if current_player == player_one
			session[:message] = "#{current_player.name}, you're all done and ready!\n please click 'Next' and let #{other_player.name} get set!"
		else
			session[:second_player_done] = true
			session[:message] = "#{current_player.name}, you're all done and ready!\n please click 'Start Game' to continue!"
		end	
	end
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	erb :setup
	redirect '/setup_player_one'
end

get '/player_turn' do
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	session[:message] = "#{current_player_name}\nclick on the coordinate you want to attack!"
	erb :player_turn
end

post '/player_turn' do
	switch_turn
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	session[:message] = "#{current_player_name}\nclick on the coordinate you want to attack!"
	erb :player_turn
end

post '/player_attack' do
	coordinate = params[:attack_coord].to_sym
	attack_result = game.attack(coordinate)
	if game.over?
		session[:message]= "Game Over!\nCongradulations #{current_player_name}, you're the winner!"	
		# redirect '/end_game'
		session[:game_over] = true
		erb :player_switch_turn
	else
		if (attack_result == :hit)
			hit_ship = attacked_ship(coordinate)
			if hit_ship.sunk?
				session[:sunk_ships_coordinates] = sunk_ships_coordinates
				if hit_ship.class.to_s == "Battleship"
					session[:message]= "#{current_player_name}\nyou totally sunk #{other_player_name}'s Battleship!"	
				else
					session[:message]= "#{current_player_name}\nyou totally sunk one of #{other_player_name}'s #{hit_ship.class.to_s}s!"	
				end
			else
				session[:message]= "#{current_player_name}\nyou hit one of #{other_player_name}'s ships!"	
			end
		else
			session[:message]= "#{current_player_name}\nnice try, but there's nothing there!"	
		end
	end
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	erb :player_switch_turn
end

post "/player_switch_turn" do 
	session[:player_one_ships] = player_one_floating_ships
	session[:player_two_ships] = player_two_floating_ships
	erb :player_turn
end

get '/end_game' do
	erb :end_game 
end

def player_occupied_coordinates
	game.player_one.occupied_coordinates
end

def player_two_occupied_coordinates
	game.player_two.occupied_coordinates
end

def current_player_occupied_coordinates
	game.current_player.occupied_coordinates
end

def create_game
	Game.new
end

def game
	session[:game]
end

def player_one
	game.player_one
end

def player_two
	game.player_two
end

def current_player
	game.current_turn
end	

def other_player
	game.other_player
end

def switch_turn
	game.switch_turn
end

def	current_player_name
	game.current_player.name
end

def	other_player_name
	game.other_player.name
end

def set_player_name player, new_name
	game.set_player_name(player, new_name)
end

def place ship
	game.place(ship)
end

def name_of ship_type
	ship_type.to_s.capitalize
end

def play_loop_until_game_over
	while !game.over?
		play_turn
		switch_turn
	end
end

def play_turn
	# coordinate = get_attack_coordinate_from(current_player)
	# print attack_result_message(get_attack_result(coordinate))
end

def get_attack_result(coordinate)
	game.attack(coordinate).to_s.capitalize!
end

def hit_coordinates
	game.hit_coordinates
end

def attacked_ship coordinate
	game.attacked_ship coordinate
end

def player_one_floating_ships
	floating_ships = game.player_one_floating_ships.flatten.map {|ship| ship.class.to_s}
	floating_ships.sort!
	floating_ships.join("<br/>")
end

def player_two_floating_ships
	floating_ships = game.player_two_floating_ships.flatten.map {|ship| ship.class.to_s}
	floating_ships.sort!
	floating_ships.join("<br/>")
end

def sunk_ships
	game.sunk_ships
end

def sunk_ships_coordinates
	game.sunk_ships_coordinates
end

def winner_name
	game.winner_name
end

def grid_array
	coord_str = ""
	for i in "A".."J"
		for j in "1".."10"
			string += i+j+", "
		end
	end
	string.split(', ')
end

