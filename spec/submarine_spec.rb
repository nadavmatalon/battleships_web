require "./lib/submarine"

describe Submarine do 

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:submarine) {Submarine.new(coordinates_1)}

	it "has a single coordinate" do
		expect(submarine.coordinates).to eq coordinates_1
	end

	it "cannot have more than a single coordinate" do
		expect(lambda{Submarine.new(coordinates_2)}).to raise_error
	end

end