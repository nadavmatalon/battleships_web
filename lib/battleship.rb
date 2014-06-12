require_relative "ship"

class Battleship < Ship

	def initialize(coordinates)
		@coordinates = coordinates
		raise "Battleship always has four coordinates" if coordinates_list.count != 4
		super(coordinates)
	end
end