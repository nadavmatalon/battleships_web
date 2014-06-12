require_relative "coordinates"

class Ship

	def initialize(coordinates)
		@coordinates = coordinates
		@hits = []
	end

	def coordinates
		@coordinates
	end

	def hit(coordinate)
		@hits << coordinate if can_be_hit_at?(coordinate)
		self
	end

	def hits
		@hits
	end

	def hit?
		hits.any?
	end

	def sunk?
		hits.count == coordinates_list.count
	end

	def can_be_hit_at?(coordinate)
		coordinates_list.include?(coordinate) && !hits.include?(coordinate)
	end

	def coordinates_list
		coordinates.into_array
	end
end




