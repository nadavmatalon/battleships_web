require_relative "player"

class Game

	def initialize
		create_player_one
		create_player_two
		add_players_to_game
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



