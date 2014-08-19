describe "setup grid", type: :feature  do

	subject { page }

	context "initially" do

		before (:each) { login_players }

		it "has 21 legend designators" do
			within "#setup-grid" do
				should have_selector :xpath, '//input[@class="legend color-white"]', count: 21
			end
		end

		it "has row legend designators marked A-J" do
			within "#setup-grid" do
				("A".."J").each { |i| should have_selector :xpath, "//input[@value=\'"+i+"\']" }
			end
		end

		it "has column legend designators markd 1-10" do
			within "#setup-grid" do
				("1".."10").each { |i| should have_selector :xpath, "//input[@value=\'"+i+"\']" }
			end
		end

		it "has 1 empty legend designator at the top-left of the grid" do
			within "#setup-grid" do
				should have_selector :xpath, '//input[@value=" "]', count: 1
			end
		end

		it "legend row designators are disabled" do
			within "#setup-grid" do		
				("1".."10").each { |i| should have_button "#{i}", disabled: true }
			end
		end

		it "legend column designators are disabled" do
			within "#setup-grid" do
				("1".."10").each { |i| should have_button "#{i}", disabled: true }
			end
		end

		it "selectable coordinates each have a uniqe value between A1-J10" do
			within "#setup-grid" do
				("A".."J").each do |i| 
					("1".."10").each do |j| 
						should have_selector :xpath, "//input[@value=\'"+i+j+"\']"
					end
				end
			end
		end

		it "has no coordinates selected" do
			should have_selector :xpath, '//input[@class="coord"]', count: 100 
			should have_selector :xpath, '//input[@class="selected"]', count: 0
		end

		it "can have a coordinate selected" do
			within '#setup-grid' do
				click_button 'A1'
				should have_selector :xpath, '//input[@class="selected"]', count: 1
			end
		end

		it "can have a coordinate unselected" do
			within '#setup-grid' do
				2.times { click_button 'A1' }
				should have_selector :xpath, '//input[@class="selected"]', count: 0
			end
		end

		it "enables players to place a ship" do
			place_ship %w(A1 A2 A3 A4)
			within "#player-one-ships" do
				should have_content "Battleship"
			end
		end	

		it "placing a ship disables its coordinates on the grid" do
			place_ship %w(A1 A2 A3 A4)
			within '#setup-grid' do
				("A1".."A4").each { |i| should have_button i, disabled: true }
			end
		end	

		it "enables players to place more than one ship" do
			[%w(A1 A2 A3 A4), %w(A5 A6 A7)].each { |coordinates| place_ship coordinates }
			within "#player-one-ships" do
				should have_content "Battleship"
				should have_content "Cruiser"
			end
		end	

		it "does not allow player to place ship at illegitimate coordinates" do
			place_ship %w(A1 A2 A3 A5)
			within "#player-one-ships" do
				should_not have_content "Battleship"
			end
		end	

		it "does not allow player to place ship without selecting coordinates" do
			should_not have_content "please try again"
			click_button 'Submit'
			should have_content "please try again"
		end	

		it "shows the currect message if ship isn\'t successfully placed" do
			should_not have_content "please try again"
			place_ship %w(A1 A2 A3 A5)
			should have_content "please try again"
		end	

		it "enables player one to place all ten ships" do
			within '#setup-grid' do
				should have_selector :xpath, '//input[@class="selected"]', count: 0
			end
			place_all_ships
			within '#setup-grid' do
				should have_selector :xpath, '//input[@class="selected"]', count: 20
			end
		end	
	end

	context "after player one placed all ships" do 

		before (:each) do 
			login_players
			place_all_ships
		end

		it "lists all ships that player one placed successfully" do
			ships = %w(Battleship Cruiser Destroyer Submarine)
			within "#player-one-ships" do
				ships.each_with_index { |ship, i| should have_content ship, count: i+1 }
			end
		end	

		it "replaces 'Submit' with 'Next' button after player one placed all ships" do
			should_not have_button 'Submit'
			should have_button 'Next'
		end

		it "shows correct message after player one placed all ten ships successfully" do
			should have_content "John, you're all done and ready!"
			should have_content "please click 'Next' and let Jane get set!"
		end

		it "enables player two to place all ten ships" do
			click_button 'Next'
			within '#setup-grid' do
				should have_selector :xpath, '//input[@class="selected"]', count: 0
			end
			place_all_ships
			within '#setup-grid' do
				should have_selector :xpath, '//input[@class="selected"]', count: 20
			end
		end
	end

	context "after player two placed all ships" do 

		before (:each) do 
			login_players
			place_all_ships
			click_button 'Next'
			place_all_ships
		end

		it "lists all ships that player two placed successfully" do
			ships = %w(Battleship Cruiser Destroyer Submarine)
			within "#player-two-ships" do
				ships.each_with_index { |ship, i| should have_content ship, count: i+1 }
			end
		end	

		it "replaces 'Submit' with 'Start Game' button after player two placed all ships" do
			should_not have_button 'Submit'
			should have_button 'Start Game'
		end

		it "shows correct message after player two placed all ten ships successfully" do
			should have_content "Jane, you're all done and ready!"
			should have_content "please click 'Start Game' to continue!"
		end
	end
end

