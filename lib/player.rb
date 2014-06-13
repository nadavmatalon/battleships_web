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

	def attacked_coordinates
		board.attacked_cooridnates
	end

	def sunk_ships
		board.sunk_ships
	end

	def sunk_ships_count
		sunk_ships.count
	end

end




