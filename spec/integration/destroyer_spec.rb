require "./lib/destroyer.rb"

describe Destroyer do 

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:c_3) {Coordinate.new(:C1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:destroyer) {Destroyer.new(coordinates_2)}

	it "has two coordinates" do
		expect(destroyer.coordinates).to eq coordinates_2
		expect(destroyer.coordinates.locations.count).to eq 2
	end

	it "can only have two coordinates" do
		expect(lambda{Destroyer.new(coordinates_1)}).to raise_error
		expect(lambda{Destroyer.new(coordinates_3)}).to raise_error
	end

end