require_relative "game"

SUNK_SHIPS_TO_WIN = 1

def current_player
	game.current_turn
end	

def other_player
	game.other_player
end

def switch_turn
	game.switch_turn
end

def clear_screen
	system "clear" or system "cls"
end

def run_game
	initialize_new_game
	play_loop_until_game_over
	announce_winner
end

def	current_player_name
	current_player == game.player_one ? "PLAYER ONE" : "PLAYER TWO"
end

def	other_player_name
	current_player == game.player_one ? "PLAYER TWO" : "PLAYER ONE"
end

def initialize_new_game
	create_game
	show_welcome_message
	board_setup_stage
	show_lets_play_massage
end

def show_welcome_message
	clear_screen
	print welcome_message
	hit_any_key_to_continue
end

def welcome_message
	"\nWELCOME TO BATTLESHIPS\n"
end

def create_game
	@game = Game.new
end

def game
	@game
end

def board_setup_stage
	2.times do
		clear_screen
		print begin_setup_message
		place_ships_sequence
		print end_setup_message
		switch_turn
		hit_any_key_to_continue
	end
end

def begin_setup_message
	"#{current_player_name} SETUP\n\n"
end

def place_ships_sequence
	place :battleship
	# 2.times {place :cruiser}
	# 3.times {place :destroyer}
	# 4.times {place :submarine}
end

def place ship_type
	array = calculate_coordinates_for(ship_type)
	case ship_type
		when :battleship then
			game.place(Battleship.new(Coordinates.new(array[0], array[1], array[2], array[3])))
		when :cruiser then
			game.place(Cruiser.new(Coordinates.new(array[0], array[1], array[2])))
		when :destroyer then
			game.place(Destroyer.new(Coordinates.new(array[0], array[1])))
		when :submarine then
			game.place(Submarine.new(Coordinates.new(array[0])))
	end
end

def calculate_coordinates_for ship_type
	first_coordinate = get_initial_coordinate_for(ship_type)
	position = get_ship_position (ship_type)
	generate_coordinates_based_on(ship_type, position, first_coordinate)
end

def get_initial_coordinate_for ship_type
	print coordinate_request_message_for(ship_type)
	print player_prompt
	coordinate = get_coordinate_from(user_input)
	if game.valid?(coordinate)
		return coordinate
	else
		print ilegitimate_coordinate_message
		get_initial_coordinate_for ship_type
	end
end

def coordinate_request_message_for(ship_type)
	"Please select initial coordinate for #{name_of ship_type}:\n(coordinate represents the top-left corner of the ship)\n\n"
end

def player_prompt
	"#{current_player_name} > "
end

def get_coordinate_from user_input
	coordinate = user_input.capitalize.to_sym
end

def get_ship_position (ship_type)
	print_position_selection_message(ship_type)
	position_selection = user_input
	if (position_selection.downcase == "h") 
		position = :horizontal
	elsif (position_selection.downcase == "v") 
		position = :vertical
	else 
		print incorrect_selection_message
		get_ship_position(ship_type)
	end
	position
end

def print_position_selection_message(ship_type)
	print "\nplease select position of #{name_of ship_type}"
	print "(H = Horizontal / V = Vertical)\n\n"
	print player_prompt
end

def name_of ship_type
	ship_type.to_s.capitalize
end

def incorrect_selection_message
	"\nSorry, incorrect selection - please try again.\n\n"
end

def generate_coordinates_based_on ship_type, position, first_coordinate
	coordinates = []
	coordinates << first_coordinate
	case ship_type
		when :destroyer then
			second_coordinate = get_next_coordinate(first_coordinate, position)
			coordinates << second_coordinate
		when :cruiser then
			second_coordinate = get_next_coordinate(first_coordinate, position)
			coordinates << second_coordinate
			third_coordinate = get_next_coordinate(second_coordinate, position)
			coordinates << third_coordinate
		when :battleship then
			second_coordinate = get_next_coordinate(first_coordinate, position)
			coordinates << second_coordinate
			third_coordinate = get_next_coordinate(second_coordinate, position)
			coordinates << third_coordinate
			forth_coordinate = get_next_coordinate(third_coordinate, position)
			coordinates << forth_coordinate
	end
	create_ship(coordinates, ship_type)
end

def get_next_coordinate(start_coordinate, position)
	if (position == :horizontal)
		row_designator = start_coordinate.slice(0)
		column_designator = start_coordinate.slice(1..2).next
		coordinate = (row_designator + column_designator).to_sym	
	else
		row_designator = start_coordinate.slice(0).next
		column_designator = start_coordinate.slice(1..2)
		coordinate = (row_designator + column_designator).to_sym
	end
	coordinate
end

def create_ship(coordinates,ship_type)
	coordinate_array = []
	coordinates.each do |coordinate|
		new_coordinate = Coordinate.new(coordinate)
		coordinate_array << new_coordinate
	end
	coordinate_array
end

def end_setup_message
	"\nThanks, #{current_player_name}!\n\n"
end

def hit_any_key_to_continue
	print hit_any_key_message
	begin
			system("stty raw -echo")
			str = STDIN.getc
	ensure
			system("stty -raw echo")
	end
end

def hit_any_key_message
	"\n(hit any key to continue)\n\n"
end

def show_lets_play_massage
	clear_screen
	print lets_play_message
end		

def lets_play_message
	"Let\'s play!\n\n"
end

def play_loop_until_game_over
	while !game.over?
		play_turn
		switch_turn
	end
end

def play_turn
	coordinate = get_attack_coordinate_from(current_player)
	print attack_result_message(get_attack_result(coordinate))
end


def get_attack_coordinate_from(current_player)
	print attack_coordinate_request_message
	print player_prompt
	coordinate = get_coordinate_from(user_input)
	if game.valid?(coordinate)
		if !(other_player.previously_attacked?(coordinate))
			coordinate
		else
			print "\nSorry, this coordinate was already attacked - please try again.\n\n"
			get_attack_coordinate_from(current_player)
		end
	else
		print ilegitimate_coordinate_message
		get_attack_coordinate_from(current_player)
	end
end	

def ilegitimate_coordinate_message
	"\nSorry, this is not a legitimate coordinate - please try again.\n\n"
end

def attack_coordinate_request_message
	"Please select coordinate to attack:\n\n"
end

def get_attack_result(coordinate)
	game.attack(coordinate).to_s.capitalize!
end

def attack_result_message(attack_result)
	"\n#{attack_result}!\n\n"
end

def announce_winner
	print "GAME OVER\n\n"
	print "The winner is #{winner_name}\n\n"
end

def winner_name
	other_player_name
end

def user_input 
	gets.chomp
end


run_game

