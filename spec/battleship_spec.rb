require "./lib/battleship.rb"

describe Battleship do 

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:c_3) {Coordinate.new(:C1)}
	let(:c_4) {Coordinate.new(:D1)}
	let(:c_5) {Coordinate.new(:E1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_4) {Coordinates.new(c_1, c_2, c_3, c_4)}
	let(:coordinates_5) {Coordinates.new(c_1, c_2, c_3, c_4, c5)}
	let(:battleship) {Battleship.new(coordinates_4)}

	it "has a four coordinates" do
		expect(battleship.coordinates).to eq coordinates_4
		expect(battleship.coordinates.locations.count).to eq 4
	end

	it "can only have four coordinates" do
		expect(lambda{Battleship.new(coordinates_1)}).to raise_error
		expect(lambda{Battleship.new(coordinates_2)}).to raise_error
		expect(lambda{Battleship.new(coordinates_3)}).to raise_error
		expect(lambda{Battleship.new(coordinates_5)}).to raise_error
	end

end