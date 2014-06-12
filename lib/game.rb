require_relative "player"

class Game

	def initialize
		set_up_players
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

	def add_players_to_game
		players.push(player_one, player_two)
	end

end



