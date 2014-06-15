require_relative "player"

class Game

	SUNK_SHIPS_TO_WIN = 1

	def initialize
		set_up_players
		@current_turn = player_one
	end

	def set_up_players
		create_players
		add_players_to_game
	end

	def create_players
		create_player_one
		create_player_two
	end

	def players
		@players ||= []
	end

	def player_one
		@player_one
	end

	def player_two
		@player_two
	end

	def create_player_one
		@player_one = Player.new
	end

	def create_player_two
		@player_two = Player.new
	end

	def set_player_name player, new_name
		player.set_name(new_name)
	end

	def add_players_to_game
		players.push(player_one, player_two)
	end

	def current_turn
		@current_turn
	end

	def switch_turn
		@current_turn = other_player
	end

	def over?
		player_one.sunk_ships_count == SUNK_SHIPS_TO_WIN ||
		player_two.sunk_ships_count == SUNK_SHIPS_TO_WIN
	end

	def other_player
		current_turn == player_one ? @other_player = player_two : @other_player = player_one
	end

	def current_player
		@current_turn
	end

	def	current_player_name
		current_player == player_one ? "PLAYER ONE" : "PLAYER TWO"
	end

	def	other_player_name
		current_player == player_one ? "PLAYER TWO" : "PLAYER ONE"
	end

	def place ship
		ship_count = current_player.ship_count
		current_player.place ship
		current_player.ship_count == ship_count + 1
	end

	def attack coordinate
		other_player.attack coordinate
	end

	def valid? coordinate
		current_player.valid? coordinate
	end

	def winner_name
		other_player_name
	end

end



