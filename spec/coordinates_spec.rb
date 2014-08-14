require "./lib/coordinates.rb"

describe Coordinates do

	let(:c_1) {Coordinate.new(:A1)}
	let(:c_2) {Coordinate.new(:B1)}
	let(:c_3) {Coordinate.new(:C1)}
	let(:c_4) {Coordinate.new(:E1)}
	let(:c_5) {Coordinate.new(:F1)}
	let(:coordinates_1) {Coordinates.new(c_1)}
	let(:coordinates_2) {Coordinates.new(c_1, c_2)}
	let(:coordinates_3) {Coordinates.new(c_1, c_2, c_3)}
	let(:coordinates_4) {Coordinates.new(c_1, c_2, c_3, c_4)}
	let(:coordinates_5) {Coordinates.new(c_1, c_2, c_3, c_4, c_5)}

	it "can contain one coordinate" do
		expect(coordinates_1.locations).to eq [c_1]
	end
	
	it "can contain two coordinate" do
		expect(coordinates_2.locations).to eq [c_1, c_2]
	end

	it "can contain three coordinate" do
		expect(coordinates_3.locations).to eq [c_1, c_2, c_3]
	end

	it "can contain four coordinate" do
		expect(coordinates_4.locations).to eq [c_1, c_2, c_3, c_4]
	end

	it "knows if it has correct length" do
		expect(coordinates_1.correct_length?).to be true
		expect(coordinates_2.correct_length?).to be true
		expect(coordinates_3.correct_length?).to be true
		expect(coordinates_4.correct_length?).to be true
		expect(coordinates_5.correct_length?).to be false
	end

	it "knows if it's coordinates are valid" do
		expect(coordinates_1.valid?).to be true
		expect(coordinates_2.valid?).to be true
		expect(coordinates_3.valid?).to be true
		expect(coordinates_4.valid?).to be false
		expect(coordinates_5.valid?).to be false
	end

end

