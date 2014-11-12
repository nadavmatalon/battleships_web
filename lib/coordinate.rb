class Coordinate

	GRID_LETTERS = ("A".."J")
	GRID_NUMBERS = ("1".."10")

	def initialize(location)
		@location = location
	end

	def location
		@location
	end

	def valid?
		symbol? && on_grid?
	end

	def symbol?
		location.is_a?Symbol
	end

	def on_grid?
		within_rows? && within_columns?
	end

	def within_rows? 
		GRID_LETTERS.include?(location.to_s.slice(0))
	end

	def within_columns? 
		GRID_NUMBERS.include?(location.to_s.slice(1..2))
	end	

	def <=>(other_coordinate)
		location.to_s <=> other_coordinate.location.to_s
	end

	def convert_to_number
		convert_row_to_number + convert_column_to_number
    end

    def convert_row_to_number
		location.to_s.slice(0).ord
	end

	def convert_column_to_number
		location.to_s.slice(1..2).to_i
	end

end

