describe "endgame", type: :feature  do

	subject { page }

	before (:each) do 
		setup_game_for_play 
	end

	it "should show the correct winning message atfer a player has won" do
		sink_all_ships
		should have_content "Game Over!"
		should have_content "Congradulations John, you're the winner"
	end

	it "should show that the losing player has no ships left" do
		within "#player-two-ships" do
			should_not have_content "No ships left"
		end
		sink_all_ships
		within "#player-two-ships" do
			should have_content "No ships left"
		end
	end

	it "should replace the 'Switch Turn' button with a 'New Game' button" do
		should_not have_button "New Game"
		sink_all_ships
		should have_button "New Game"
	end

	it "clicking 'New Game' button should start a new game" do
		should_not have_content "Welcome to Battleships!"
		should_not have_content "Click 'Start' to begin playing"
		sink_all_ships
		click_button "New Game"
		should have_content "Welcome to Battleships!"
		should have_content "Click 'Start' to begin playing"
	end
end