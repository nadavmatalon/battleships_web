
describe "homepage", type: :feature, js: false do

	before (:each) { visit "/" }

	it "should have the title \'BATTLESHIPS'" do
		expect(page).to have_content "BATTLESHIPS"
	end

	it "should have a 'Start' button" do
		expect(page).to have_button "Start"
	end

	it "should show the message \'Welcome to Battleships!\'" do
		expect(page).to have_content "Welcome to Battleships!"
	end

	it "should show the message \'Welcome to Battleships!\'" do
		expect(page).to have_content "Click 'Start' to begin playing"
	end

	it "should have the preview picture of a battleship" do
		expect(page).to have_css "#battleship_pic"
	end
end

