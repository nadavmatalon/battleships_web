require "./lib/game.rb"

describe Game do 

	let(:c1) {Coordinate.new(:A1)}
	let(:c2) {Coordinate.new(:A2)}
	let(:c3) {Coordinate.new(:A3)}
	let(:c4) {Coordinate.new(:A4)}
	let(:c5) {Coordinate.new(:A5)}
	let(:c6) {Coordinate.new(:A6)}
	let(:c7) {Coordinate.new(:A7)}
	let(:c8) {Coordinate.new(:A8)}
	let(:c9) {Coordinate.new(:A9)}
	let(:c10) {Coordinate.new(:A10)}
	let(:c11) {Coordinate.new(:B1)}
	let(:c12) {Coordinate.new(:B2)}
	let(:c13) {Coordinate.new(:B3)}
	let(:c14) {Coordinate.new(:B4)}
	let(:c15) {Coordinate.new(:B5)}
	let(:c16) {Coordinate.new(:B6)}
	let(:c17) {Coordinate.new(:B7)}
	let(:c18) {Coordinate.new(:B8)}
	let(:c19) {Coordinate.new(:B9)}
	let(:c20) {Coordinate.new(:B10)}

	let(:coords1) {Coordinates.new(c1, c2, c3, c4)}
	let(:coords2) {Coordinates.new(c5, c6, c7)}
	let(:coords3) {Coordinates.new(c8, c9, c10)}
	let(:coords4) {Coordinates.new(c11, c12)}
	let(:coords5) {Coordinates.new(c13, c14)}
	let(:coords6) {Coordinates.new(c15, c16)}
	let(:coords7) {Coordinates.new(c17)}
	let(:coords8) {Coordinates.new(c18)}
	let(:coords9) {Coordinates.new(c19)}
	let(:coords10) {Coordinates.new(c20)}

	let(:battleship) {Battleship.new(coords1)}
	let(:cruiser1) {Cruiser.new(coords2)}
	let(:cruiser2) {Cruiser.new(coords3)}
	let(:destroyer1) {Destroyer.new(coords4)}
	let(:destroyer2) {Destroyer.new(coords5)}
	let(:destroyer3) {Destroyer.new(coords6)}
	let(:sub1) {Submarine.new(coords7)}
	let(:sub2) {Submarine.new(coords8)}
	let(:sub3) {Submarine.new(coords9)}
	let(:sub4) {Submarine.new(coords10)}

	let(:game) {Game.new}

	it "is initialized with two players" do
		expect(game.players.count).to eq 2
	end

	it "keeps track of players' turns" do
		expect(game.current_turn).to eq game.player_one
	end

	it "can switch turns between the two players" do
		expect(game.current_turn).to eq game.player_one
		game.switch_turn
		expect(game.current_turn).to eq game.player_two
	end

	it "knows if it's not over" do
		expect(game.over?).to be false
	end

	it "knows if it's over" do
		game.place(battleship)
		game.place(cruiser1)
		game.place(cruiser2)
		game.place(destroyer1)
		game.place(destroyer2)
		game.place(destroyer3)
		game.place(sub1)
		game.place(sub2)
		game.place(sub3)
		game.place(sub4)
		game.switch_turn
		for i in "1".."10"
			game.attack(("A"+i).to_sym)
			game.attack(("B"+i).to_sym)
		end
		expect(game.over?).to be true
	end

	it "knows who won" do
		game.set_player_name "Player One"
		game.switch_turn
		game.set_player_name "Player Two"
		game.switch_turn
		game.place(battleship)
		game.place(cruiser1)
		game.place(cruiser2)
		game.place(destroyer1)
		game.place(destroyer2)
		game.place(destroyer3)
		game.place(sub1)
		game.place(sub2)
		game.place(sub3)
		game.place(sub4)
		game.switch_turn
		for i in "1".."10"
			game.attack(("A"+i).to_sym)
			game.attack(("B"+i).to_sym)
		end
		game.switch_turn
		expect(game.winner_name).to eq game.player_two.name
	end
end

