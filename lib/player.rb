require_relative "board"

class Player

	def initialize(board = Board.new)
		@board = board
	end

	def board
		@board
	end

	def ships
		@ships = board.ships
	end

	def ship_count
		ships.count
	end

	def place new_ship
		board.place new_ship
	end

	def attack coordinate
		board.attack coordinate
	end

	def attacked? coordinate
		board.attacked? coordinate
	end


end




