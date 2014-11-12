require_relative "ship"
require_relative "submarine"
require_relative "destroyer"
require_relative "cruiser"
require_relative "battleship"

class Board

	def initialize(ships = [])
		@ships = ships
		@attacked_cooridnates = []
		@hit_coordinates = []
	end

	def ships
		@ships
	end

	def ship_count
		ships.count
	end

	def place new_ship
		@ships << new_ship if !ship_already_present? new_ship
	end

	def ship_already_present? new_ship
		(occupied_coordinates & new_ship.coordinates_list).any?
	end

	def occupied_coordinates
		(ships.map {|ship| ship.coordinates_list}).flatten
	end

	def hit_coordinates
		@hit_coordinates
	end

	def attack coordinate
		# return "This is not a valid coordinate" if !coordinate.valid?
		return "This coordinate was already attacked" if previously_attacked?(coordinate)
		attacked_cooridnates << coordinate
		attack_result = check_attack_result_on coordinate
	end

	def check_attack_result_on coordinate 
		if successful_attack_on? coordinate
			attacked_ship(coordinate).hit coordinate
			hit_coordinates << coordinate
			:hit
		else
			:miss
		end
	end

	def attacked_cooridnates
		@attacked_cooridnates.sort!
	end

	def successful_attack_on? coordinate
		(occupied_coordinates & [coordinate]).any?
	end

	def attacked_ship coordinate
		identify_ship_by coordinate
	end

	def identify_ship_by coordinate
		ships.detect {|ship| ship.matching? coordinate}
	end

	def sunk_ships_count
		sunk_ships.count
	end

	def sunk_ships
		ships.select {|ship| ship.sunk?}
	end

	def floating_ships
		ships.select {|ship| !ship.sunk?}
	end

	def previously_attacked? coordinate
		(attacked_cooridnates & [coordinate]).any?
	end

	def sunk_ships_coordinates
		sunk_ships_coordinates = sunk_ships.map {|sunk_ship| sunk_ship.hits}
		sunk_ships_coordinates.flatten!
	end

end

