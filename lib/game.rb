require_relative "player"

class Game

SHIPS_TO_PLACE = 10
SUNK_SHIPS_TO_WIN = 10

	attr_reader :player_one, :player_two

	def initialize
		@player_one = Player.new
		@player_two = Player.new
		players.push(@player_one, @player_two)
		@current_turn = player_one
	end

	def players
		@players ||= []
	end

	def set_player_name new_name
		current_player.set_name new_name
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
		current_player.name
	end

	def	other_player_name
		other_player.name
	end

	def place ship
		current_player.place(ship)
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

	def attacked_coordinates
		other_player.attacked_cooridnates
	end

	def player_one_floating_ships
		player_one.floating_ships
	end

	def player_two_floating_ships
		player_two.floating_ships
	end

	def sunk_ships
		other_player.sunk_ships
	end

	def sunk_ships_count
		other_player.sunk_ships_count
	end

	def hit_coordinates
		other_player.hit_coordinates
	end

	def attacked_ship coordinate
		other_player.attacked_ship coordinate
	end

	def sunk_ships_coordinates
		other_player.sunk_ships_coordinates
	end
end
