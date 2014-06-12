require_relative "ship"

class Destroyer < Ship

	def initialize(coordinates)
		@coordinates = coordinates
		raise "Destroyer always has two coordinates" if coordinates_list.count != 2
		super(coordinates)
	end
end