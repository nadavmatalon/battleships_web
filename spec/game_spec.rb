require "./lib/game.rb"

describe Game do 

	let(:game) {Game.new}
	let(:coordinate) {Coordinate.new(:A1)}
	let(:coordinate_2) {Coordinate.new(:A2)}
	let(:coordinates) {Coordinates.new(coordinate)}
	let(:coordinates_2) {Coordinates.new(coordinate_2)}
	let(:submarine) {Submarine.new(coordinates)}
	let(:submarine_2) {Submarine.new(coordinates_2)}

	it "is initialized with two players" do
		expect(game.players.count).to eq 2
	end

	it "knows whose turn it currently is (player_one/player_two)" do
		expect(game.current_turn).to eq game.player_one
	end


	it "can switch turns between player_one and player_two" do
		expect(game.current_turn).to eq game.player_one
		game.switch_turn
		expect(game.current_turn).to eq game.player_two
	end

	it "knows if the game is not over" do
		expect(game.over?).to be false
	end

	it "knows if the game is over" do
		game.place(submarine)
		game.place(submarine_2)
		game.switch_turn
		game.attack(:A1)
		game.attack(:A2)
		expect(game.over?).to be true
	end

	it "knows who won" do
		game.place(submarine)
		game.place(submarine_2)
		game.switch_turn
		game.attack(:A1)
		game.attack(:A2)
		expect(game.winner_name).to eq game.player_two.name
	end

	it "knows if placing of a ship is successful" do
		expect(game.place(submarine)).to be true
		expect(game.place(submarine)).to be false
	end

end



