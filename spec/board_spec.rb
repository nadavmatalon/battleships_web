require "./lib/board.rb"

describe Board do 

	let(:a_1) {Coordinate.new(:A1)}
	let(:a_2) {Coordinate.new(:A2)}
	let(:b_1) {Coordinate.new(:B1)}
	let(:b_2) {Coordinate.new(:B2)}
	let(:b_3) {Coordinate.new(:B3)}
	let(:c_1) {Coordinate.new(:C1)}
	let(:c_2) {Coordinate.new(:C2)}
	let(:c_3) {Coordinate.new(:C3)}
	let(:c_4) {Coordinate.new(:C4)}
	let(:d_1) {Coordinate.new(:D1)}
	let(:d_2) {Coordinate.new(:D2)}
	let(:d_3) {Coordinate.new(:D3)}
	let(:d_4) {Coordinate.new(:D4)}
	let(:d_5) {Coordinate.new(:D5)}
	let(:coordinates_1) {Coordinates.new(a_1)}
	let(:coordinates_2) {Coordinates.new(b_1, b_2)}
	let(:coordinates_3) {Coordinates.new(a_1, a_2)}
	let(:coordinates_4) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_5) {Coordinates.new(b_1, b_2, b_3)}
	let(:coordinates_6) {Coordinates.new(d_1, d_2, d_3, d_4)}
	let(:submarine) {Submarine.new(coordinates_1)}
	let(:destroyer_1) {Destroyer.new(coordinates_2)}
	let(:destroyer_2) {Destroyer.new(coordinates_3)}
	let(:cruiser_1) {Cruiser.new(coordinates_4)}
	let(:cruiser_2) {Cruiser.new(coordinates_5)}
	let(:battleship) {Battleship.new(coordinates_6)}
	let(:board) {Board.new}

	it "has no ships placed on it when initialized" do
		expect(board.ship_count).to eq 0
	end

	it "can have a submarine placed on it" do
		board.place(submarine)
		expect(board.ship_count).to eq 1
		expect(board.ships).to eq [submarine]
	end

	it "can have a destroyer placed on it" do
		board.place(destroyer_1)
		expect(board.ship_count).to eq 1
		expect(board.ships).to eq [destroyer_1]
	end

	it "can have a cruiser placed on it" do
		board.place(cruiser_1)
		expect(board.ship_count).to eq 1
		expect(board.ships).to eq [cruiser_1]
	end

	it "can have a battleship placed on it" do
		board.place(battleship)
		expect(board.ship_count).to eq 1
		expect(board.ships).to eq [battleship]
	end

	it "cannot have two ships placed on it with a shared coordinate" do
		board.place(submarine)
		board.place(destroyer_2)
		expect(board.ship_count).to eq 1
		expect(board.ships).to eq [submarine]
	end

	it "registers a succesful attack on a ship" do
		board.place(submarine)
		expect(board.successful_attack_on?(:A1)).to be true
	end

	it "registers hits on ships if attacks are successful" do
		board.place(submarine)
		board.attack(:A1)
		expect(submarine.hit?).to be true
		expect(submarine.sunk?).to be true
	end

	it "knows which ships have sunk" do
		board.place(submarine)
		board.place(destroyer_1)
		board.attack(:A1)
		expect(board.sunk_ships).to eq [submarine]
	end

	it "knows how many ships sunk" do
		board.place(submarine)
		board.place(destroyer_1)
		board.attack(:A1)
		expect(board.sunk_ships_count).to eq 1
	end

 	it "cannot register an attack on the same coordinate twice" do
		board.attack(:A1)
		message = "This coordinate was already attacked"
		expect(board.attack(:A1)).to eq message
 	end

 	it "knows which coordinates were attacked" do
		board.attack(:A1)
		expect(board.previously_attacked?(:A1)).to be true
		expect(board.previously_attacked?(:A2)).to be false 		
 	end

 	it "knows which coordinates were attacked" do
		board.attack(:A5)
		board.attack(:A1)
		expect(board.attacked_cooridnates).to eq [:A1, :A5]
 	end

end



