require_relative "ship"

class Submarine < Ship

	def initialize(coordinates)
		@coordinates = coordinates
		raise "Submarine only has a single coordinate" if coordinates_list.count != 1
		super(coordinates)
	end
end