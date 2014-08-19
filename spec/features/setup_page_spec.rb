
describe "setup page", type: :feature, js: :true  do

	before (:each) do 
		login_players
	end

	it "should have the title \'BATTLESHIPS\'" do
		expect(page).to have_content "BATTLESHIPS"
	end

	it "should show the setup grid" do
		expect(page).to have_css "#setup-grid"
	end

	it "should have a 'Submit' button" do
		expect(page).to have_button "Submit"
	end

	it "should show the correct first setup message for player one" do
		expect(page).to have_content "John, your first ship is a Battleship!"
		expect(page).to have_content "To place it on the board, click on 4 consequtive squares and then hit 'Submit'"
	end

	it "should show the list of ships for player one" do
		expect(page).to have_content "John's Armada"
	end
	
	it "should show the list of ships for player two" do
		expect(page).to have_content "Jane's Armada"
	end

	it "should show that initially players one\'s list of ships is empty" do
		within "#player-one-ships" do
			expect(page).to have_content "No ships yet"
		end
	end

	it "should show that initially players two\'s list of ships is empty" do
		within "#player-two-ships" do
			expect(page).to have_content "No ships yet"
		end
	end
end


def login_players
	visit "/"
	click_button "Start"
	fill_in "player-one-name-box", with: "John"
	click_button "Submit"
	fill_in "player-two-name-box", with: "Jane"
	click_button "Submit"
	click_button "Setup"
end




 