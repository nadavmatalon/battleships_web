require_relative "board"

class Player

	def initialize(name = "Player", board = Board.new)
		@name = name
		@board = board
	end

	def board
		@board
	end

	def name
		@name
	end

	def set_name new_name
		@name = new_name
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

	def previously_attacked? coordinate
		board.previously_attacked? coordinate
	end

	def valid? coordinate
		board.valid? coordinate
	end

	def occupied_coordinates
		board.occupied_coordinates
	end



end




