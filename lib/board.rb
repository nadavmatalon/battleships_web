require_relative "submarine"
require_relative "destroyer"
require_relative "cruiser"
require_relative "battleship"

class Board

	def initialize(ships = [])
		@ships = ships
		@attacked_cooridnates = []
	end

	def ships
		@ships
	end

	def ship_count
		ships.count
	end

	def place new_ship
		@ships << new_ship unless ship_already_present?(new_ship)
	end

	def ship_already_present? new_ship
		(occupied_coordinates & new_ship.coordinates_list).any?
	end

	def occupied_coordinates
		(ships.map {|ship| ship.coordinates_list}).flatten
	end

	def attack coordinate
		attacked_cooridnates << coordinate if valid?(coordinate) && !attacked?(coordinate)
		attacked_ship(coordinate).hit coordinate if successful_attack_on? coordinate
	end

	def attacked_cooridnates
		@attacked_cooridnates
	end

	def successful_attack_on? coordinate
		(occupied_coordinates & [coordinate]).any?
	end

	def attacked_ship coordinate
		identify_ship_by coordinate
	end

	def identify_ship_by coordinate
		ships.detect {|ship| matching? ship, coordinate}
	end

	def matching? ship, coordinate
		(ship.coordinates_list & [coordinate]).any?
	end

	def sunk_ships_count
		sunk_ships.count
	end

	def sunk_ships
		ships.select {|ship| ship.sunk?}
	end

	def attacked? coordinate
		(attacked_cooridnates & [coordinate]).any?
	end

	def valid? coordinate
		Coordinate.new(coordinate).valid?
	end

end

