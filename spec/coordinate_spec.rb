require "./lib/coordinate.rb"

describe Coordinate do

	let(:coordinate_1) {Coordinate.new(:B5)}
	let(:coordinate_2) {Coordinate.new(:K11)}
	let(:coordinate_3) {Coordinate.new(1)}
	let(:coordinate_4) {Coordinate.new("a")}

	it "knows if it's location is marked by a symbol" do
		expect(coordinate_1.symbol?).to be true
		expect(coordinate_2.symbol?).to be true
		expect(coordinate_3.symbol?).to be false
		expect(coordinate_4.symbol?).to be false
	end

	it "knows if it's located on the (imaginary) grid" do
		expect(coordinate_1.on_grid?).to be true
		expect(coordinate_2.on_grid?).to be false
		expect(coordinate_3.on_grid?).to be false
		expect(coordinate_4.on_grid?).to be false
	end

	it "knows if it's a valid coordinate" do
		expect(coordinate_1.valid?).to be true
		expect(coordinate_2.valid?).to be false
		expect(coordinate_3.valid?).to be false
		expect(coordinate_4.valid?).to be false
	end

	context 'compares coordinates' do
		let(:a_one) { Coordinate.new(:A1) }
		let(:a_two) { Coordinate.new(:A2) }
		let(:a_one_two) { Coordinate.new(:A1) }

		it 'a1 <=> a2' do
			expect(a_one <=> a_two).to eq -1
		end

		it 'a2 <=> a1' do
			expect(a_two <=> a_one).to eq 1
		end

		it 'a1 <=> a1' do
			expect(a_one_two <=> a_one).to eq 0
		end

	end

end