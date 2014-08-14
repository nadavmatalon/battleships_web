require "./lib/cruiser.rb"

describe Cruiser do 

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:c_3) {Coordinate.new(:C1)}
	let(:c_4) {Coordinate.new(:D1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_4) {Coordinates.new(c_1, c_2, c_3, c_4)}
	let(:cruiser) {Cruiser.new(coordinates_3)}

	it "has three coordinates" do
		expect(cruiser.coordinates).to eq coordinates_3
		expect(cruiser.coordinates.locations.count).to eq 3
	end

	it "can only have three coordinates" do
		expect(lambda{Cruiser.new(coordinates_1)}).to raise_error
		expect(lambda{Cruiser.new(coordinates_2)}).to raise_error
		expect(lambda{Cruiser.new(coordinates_4)}).to raise_error
	end

end