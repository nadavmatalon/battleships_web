require "./lib/player.rb"

describe Player do 

	let(:a_1) {Coordinate.new(:A1)}
	let(:b_1) {Coordinate.new(:B1)}
	let(:b_2) {Coordinate.new(:B2)}
	let(:c_1) {Coordinate.new(:C1)}
	let(:c_2) {Coordinate.new(:C2)}
	let(:c_3) {Coordinate.new(:C3)}
	let(:d_1) {Coordinate.new(:D1)}
	let(:d_2) {Coordinate.new(:D2)}
	let(:d_3) {Coordinate.new(:D3)}
	let(:d_4) {Coordinate.new(:D4)}
	let(:coordinates_1) {Coordinates.new(a_1)}
	let(:coordinates_2) {Coordinates.new(b_1, b_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_4) {Coordinates.new(d_1, d_2, d_3, d_4)}
	let(:submarine) {Submarine.new(coordinates_1)}
	let(:destroyer) {Destroyer.new(coordinates_2)}
	let(:cruiser) {Cruiser.new(coordinates_3)}
	let(:battleship) {Battleship.new(coordinates_4)}
	let(:player) {Player.new}

	it "has an empty board" do
		expect(player.ships).to eq []

	end

	it "can place a ship on the board" do
		player.place(battleship)
		expect(player.ships).to eq [battleship]
		expect(player.ship_count).to eq 1
	end

	it "can attack a specific coordinate on the board" do
		player.place(submarine)
		expect(player.attack(:A5)).to be_false
		expect(player.attack(:A1)).to be_true
	end

	it "knows which coordinates were already attacked" do
		player.attack(:A1)
		expect(player.attacked?(:A1)).to be_true
		expect(player.attacked?(:A2)).to be_false
	end

end





