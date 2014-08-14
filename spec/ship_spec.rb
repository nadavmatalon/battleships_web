require "./lib/ship.rb"

describe Ship do

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:c_3) {Coordinate.new(:C1)}
	let(:c_4) {Coordinate.new(:D1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_4) {Coordinates.new(c_1, c_2, c_3, c_4)}
	let(:ship_1) {Ship.new(coordinates_1)}
	let(:ship_2) {Ship.new(coordinates_2)}
	let(:ship_3) {Ship.new(coordinates_3)}
	let(:ship_4) {Ship.new(coordinates_4)}

	it "has coordinates" do
		expect(ship_1.coordinates).to eq coordinates_1
	end
	
	it "will be hit when shot at" do
		expect(ship_1.hit(:A1)).to be_hit
	end

	it "is not hit by default" do
		expect(ship_1).not_to be_hit
	end

	it "can be sunk" do
		ship_1.hit(:A1)
		expect(ship_1).to be_sunk
	end

	it "will sink if it's hit a sufficient number of times" do
		ship_2.hit(:A1)
		expect(ship_2).not_to be_sunk
	end

	it "cannot be hit twice at the same coordinate" do
		ship_2.hit(:A1)
		ship_2.hit(:A1)
		expect(ship_2.hits.count).to eq 1
	end

	it "can only have its coordinates hit" do
		expect(ship_1.can_be_hit_at?(:A2)).to be false
	end

end

