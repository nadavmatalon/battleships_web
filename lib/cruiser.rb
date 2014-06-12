require_relative "ship"

class Cruiser < Ship

	def initialize(coordinates)
		@coordinates = coordinates
		raise "Cruiser always has three coordinates" if coordinates_list.count != 3
		super(coordinates)
	end
end