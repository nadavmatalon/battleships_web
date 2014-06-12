require "./lib/game.rb"

describe Game do 

	let(:game) {Game.new}
	let(:coordinate) {Coordinate.new(:A1)}
	let(:coordinates) {Coordinates.new(coordinate)}
	let(:submarine) {Submarine.new(coordinates)}

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
		expect(game.over?).to be_false
	end

	it "knows if the game is over" do
		game.place(submarine)
		game.switch_turn
		game.attack(:A1)
		expect(game.over?).to be_true
	end

	it "knows who won" do
		game.place(submarine)
		game.switch_turn
		game.attack(:A1)
		expect(game.winner).to eq game.player_two
	end

end



