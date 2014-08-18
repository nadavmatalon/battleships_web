
describe "login page", type: :feature, js: :true  do

	before (:each) do 
		visit "/"
		click_button "Start"
	end

	it "should have the title \'BATTLESHIPS\'" do
		expect(page).to have_content "BATTLESHIPS"
	end

	it "should have a 'Submit' button" do
		expect(page).to have_button "Submit"
	end

	it "should show the message \'Player One!\'" do
		expect(page).to have_content "Player One"
	end

	it "should show the message \'please enter your name\'" do
		expect(page).to have_content "please enter your name"
	end

	it "should have a text-box for player one\'s name " do
		expect(page).to have_field "player-one-name-box"
	end

	it "should have the preview picture of a battleship" do
		expect(page).to have_css "#battleship_pic"
	end

	it "shoud take player one\'s name and move to player two" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		expect(page).to have_field "player-two-name-box"
	end

	it "shoud not accept empty submit for player one\'s name" do
		click_button "Submit"
		expect(page).to have_field "player-one-name-box"
	end

	it "shoud show correct message for empty submit for player one\'s name" do
		click_button "Submit"
		expect(page).to have_content "Sorry, names can't be blank"
		expect(page).to have_content "please try again"
	end

	it "should show the current message for player two" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		expect(page).to have_content "Player Two"
		expect(page).to have_content "please enter your name"
	end

	it "shoud not accept empty submit for player one\'s name" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		click_button "Submit"
		expect(page).to have_field "player-two-name-box"
	end

	it "shoud show correct message for empty submit for player one\'s name" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		click_button "Submit"
		expect(page).to have_content "Sorry, names can't be blank"
		expect(page).to have_content "please try again"
	end

	it "shoud not accept identical names for player one and player two" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		fill_in  "player-two-name-box", with: "John"
		click_button "Submit"
		expect(page).to have_field "player-two-name-box"
	end

	it "shoud show correct message for identical names input" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		fill_in  "player-two-name-box", with: "John"
		click_button "Submit"
		expect(page).to have_content "Sorry, players names can't be identical"
		expect(page).to have_content "please try again"
	end

	it "should replace the \'Submit\' button with a \'Setup button after players login\'" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		fill_in  "player-two-name-box", with: "Jane"
		click_button "Submit"
		expect(page).not_to have_button "Submit"
		expect(page).to have_button "Setup"
	end

	it "should the correct message after players login\'" do
		fill_in  "player-one-name-box", with: "John"
		click_button "Submit"
		fill_in  "player-two-name-box", with: "Jane"
		click_button "Submit"
		expect(page).to have_content "Welcome John and Jane!"
		expect(page).to have_content "Let's set up the boards"
	end

end

