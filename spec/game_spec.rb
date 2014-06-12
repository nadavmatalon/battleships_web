require "./lib/game.rb"

describe Game do 

	let(:game) {Game.new}

	it "is initialized with two players" do
		expect(game.players.count).to eq 2
	end

end