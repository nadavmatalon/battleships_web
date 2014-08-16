require_relative "coordinate"

class Coordinates

	def initialize(*args)
		@locations = args.sort!
	end

	def locations
		@locations ||= []
	end

	def valid?
		correct_length? && sequential_locations? && same_row_or_column?
	end

	def same_row_or_column?
		return true if locations.count <= 2
		check_value = false
		locations_array = locations.map do |coordinate|
			coordinate.location	
		end			 
		row_array = locations_array.map do |location|
			location.slice(0)
		end
		column_array = locations_array.map do |location|
			location.slice(1..2)
		end
		row_array.uniq!
		column_array.uniq!
		row_array.count == 1 || column_array.count == 1
	end

	def correct_length?
		locations.count <= 4
	end

	def sequential_locations?
		return true if single_coordinate?
		locations.sort_by! { |coordinate| coordinate.convert_to_number }
		!sequence.include?(false)
	end

	def sequence
		location_pairs.map {|coord_a, coord_b| sequential_coordinates?(coord_a, coord_b) }
	end

    def sequential_coordinates?(coord_a, coord_b)
    	coord_b.convert_to_number - coord_a.convert_to_number == 1
	end

	def location_pairs
		locations.each_cons(2)
	end

	def single_coordinate?
		locations.count == 1
	end

	def into_array
		locations.map {|coordinate| coordinate.location}
	end

end
