
def setup_game_for_play
	login_players
	place_all_ships
	click_button 'Next'
	place_all_ships
	click_button 'Start Game'
end

def login_players
	visit "/"
	click_button "Start"
	fill_in "player-one-name-box", with: "John"
	click_button "Submit"
	fill_in "player-two-name-box", with: "Jane"
	click_button "Submit"
	click_button "Setup"
end

def place_ship coordinates
	within '#setup-grid' do
		coordinates.each { |i| click_button i }
	end
	click_button 'Submit'
end

def place_all_ships
	[%w(A1 A2 A3 A4), %w(A5 A6 A7), %w(A8 A9 A10), %w(B1 B2), %w(B3 B4), 
	 %w(B5 B6), %w(B7), %w(B8), %w(B9), %w(B10)].each do |coordinates|
		place_ship coordinates
	end
end

def sink_battleship
	setup_game_for_play
	2.times do
		click_button 'A1'
		click_button 'Switch Turn'
	end
	2.times do
		click_button 'A2'
		click_button 'Switch Turn'
	end
	2.times do
		click_button 'A3'
		click_button 'Switch Turn'
	end
	click_button 'A4'
end
