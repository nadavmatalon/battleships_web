require_relative "run_battleships"
require 'sinatra'

set :views, Proc.new {File.join(root, '..', "views")}
set :public, Proc.new {File.join(root, '..', "public")}

enable :sessions

get '/' do
	session[:num_of_players]= 0
	session[:player_one]= ''
	session[:player_two]= ''
	@message= 'Player One, please enter your name:'
	erb :index
end

get '/login' do
	redirect '/'
end

post '/login_player_one' do
	session[:player_one]= params[:text]
	session[:num_of_players] += 1
	@message= 'Player Two, please enter your name:'	
	erb :index
end

post '/login_player_two' do
	session[:player_two]= params[:text]
	if session[:player_two] != session[:player_one]
		session[:num_of_players] += 1
		redirect '/setup'
	else
		@message= "This is not a valid name, please try again:"
		erb :index
	end
end

get '/setup' do
	if session[:num_of_players] == 2
		@message= "Welcome #{session[:player_one]} and #{session[:player_two]}!"
		erb :index
	else
		redirect '/'
	end
end

post '/setup' do
	redirect '/setup_player_one'
end

get '/setup_player_one' do
	@message= "#{session[:player_one]}, please select start coordinate for battleship:"
	erb :setup
end

post '/place_ship' do
	ship_type=(params[:ship_type]).to_sym
	coords=params[:coords].split(", ").sort.map { |s| s.to_sym }
	ship=nil
		case ship_type
			when :submarine
				if coords.count == 1
					coordinate_1 = Coordinate.new(coords[0])
					coordinates = Coordinates.new(coordinate_1)
					ship = Submarine.new(coordinates)
				end
			when :destroyer
				if coords.count == 2
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinates = Coordinates.new(coordinate_1, coordinate_2)
					if coordinates.valid?
						ship = Destroyer.new(coordinates)
					end
				end
			when :cruiser
				if coords.count == 3
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinate_3 = Coordinate.new(coords[2])
					coordinates = Coordinates.new(coordinate_1, coordinate_2, coordinate_3)
					if coordinates.valid?
						ship = Cruiser.new(coordinates)
					end
				end
			when :battleship
				if coords.count == 4
					coordinate_1 = Coordinate.new(coords[0])
					coordinate_2 = Coordinate.new(coords[1])
					coordinate_3 = Coordinate.new(coords[2])
					coordinate_4 = Coordinate.new(coords[3])
					coordinates = Coordinates.new(coordinate_1, coordinate_2, coordinate_3, coordinate_4)
					if coordinates.valid?
						ship = Destroyer.new(coordinates)
					end
				end
		end
	if !ship.nil?
		player_one_add(ship)
		player_one_add_ship(coords)
		@message= "#{ship_type.to_s.capitalize} created at coordinates: #{coords.join(', ')}; ship count: #{player_one_ships.count}; occupied coordinates: #{player_one_occupied_coordinates}"
	else
		@message= "ship could not be created"
	end
	erb :setup
end

def player_one_ships
	@player_one_ships ||= [] 	
end

def player_one_add(ship)
	player_one_ships << ship unless player_one_ships.count == 10
end	
	
def player_one_occupied_coordinates
	@player_one_occupied_coordinates ||= []
end

def player_one_add_ship coordinates
	player_one_occupied_coordinates << coordinates
	@player_one_occupied_coordinates.flatten!
end



