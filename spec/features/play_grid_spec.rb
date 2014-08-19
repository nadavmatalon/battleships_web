describe "play grid", type: :feature  do

	subject { page }

	before (:each) { setup_game_for_play }

	context "initially" do

		it "has 21 legend designators" do
			within "#play-grid" do
				should have_selector :xpath, '//input[@class="legend color-white"]', count: 21
			end
		end

		it "has row legend designators marked A-J" do
			within "#play-grid" do
				("A".."J").each { |i| should have_selector :xpath, "//input[@value=\'"+i+"\']" }
			end
		end

		it "has column legend designators markd 1-10" do
			within "#play-grid" do
				("1".."10").each { |i| should have_selector :xpath, "//input[@value=\'"+i+"\']" }
			end
		end

		it "has 1 empty legend designator at the top-left of the grid" do
			within "#play-grid" do
				should have_selector :xpath, '//input[@value=" "]', count: 1
			end
		end

		it "legend row designators are disabled" do
			within "#play-grid" do
				("1".."10").each { |i| should have_button "#{i}", disabled: true }
			end
		end

		it "legend column designators are disabled" do
			within "#play-grid" do
				("1".."10").each { |i| should have_button "#{i}", disabled: true }
			end
		end

		it "attackable coordinates each have a uniqe value between A1-J10" do
			within "#play-grid" do
				("A".."J").each do |i| 
					("1".."10").each do |j| 
						should have_selector :xpath, "//input[@value=\'"+i+j+"\']"
					end
				end
			end
		end

		it "has no coordinates attacked" do
			should have_selector :xpath, '//input[@class="coord"]', count: 100 
			should have_selector :xpath, '//input[@class="attacked_miss"]', count: 0
			should have_selector :xpath, '//input[@class="attacked_hit"]', count: 0
			should have_selector :xpath, '//input[@class="attacked_sunk"]', count: 0
		end

		it "can have a coordinate attacked" do
			within "#play-grid" do
				click_button 'A1'
				should have_selector :xpath, '//input[@class="attacked_hit"]', count: 1
			end
		end
	end

	context "after a player's attack" do

		it "turns color of legend from white to grey" do
			within "#play-grid" do
				should have_selector :xpath, '//input[@class="legend color-white"]', count: 21
				should have_selector :xpath, '//input[@class="legend color-grey"]', count: 0
				click_button 'A1'
				should have_selector :xpath, '//input[@class="legend color-grey"]', count: 21
				should have_selector :xpath, '//input[@class="legend color-white"]', count: 0
			end
		end

		it "correctly marks the attacked corrdinate if attack is unsuccessful" do
			click_button 'D1'
			should have_selector :xpath, '//input[@class="attacked_miss"]', count: 1
		end

		it "correctly marks the attacked corrdinate if attack successful" do
			click_button 'A1'
			should have_selector :xpath, '//input[@class="attacked_hit"]', count: 1
		end

		it "correctly marks the attacked corrdinate if attack sinks ship" do
			sink_battleship
			should have_selector :xpath, '//input[@class="attacked_sunk"]', count: 4
		end

		it "shows the currect message if attack is unsuccessful" do
			should_not have_content "nice try, but there's nothing there!"
			click_button 'C1'
			should have_content "nice try, but there's nothing there!"
		end	

		it "shows the currect message if ship is hit" do
			should_not have_content "you hit one of Jane's ships!"
			click_button 'A1'
			should have_content "you hit one of Jane's ships!"
		end	

		it "shows the currect message if ship is sunk" do
			should_not have_content "you totally sunk Jane's Battleship!"
			sink_battleship
			should have_content "you totally sunk Jane's Battleship!"
		end	

		it "remove a ship from a the player's ship list if it's sunk" do
			within "#player-one-ships" do
				should have_content "Battleship"
			end
			within "#player-two-ships" do
				should have_content "Battleship"
			end
			sink_battleship
			click_button 'Switch Turn'
			click_button 'A4'
			within "#player-one-ships" do
				should_not have_content "Battleship"
			end
			within "#player-two-ships" do
				should_not have_content "Battleship"
			end
		end	

		it "doesn't allow player to attack again immidiately after attack" do
			click_button 'A1'
			("A".."J").each do |i| 
				("1".."10").each do |j| 
	 				should have_button "#{i+j}", disabled: true
 				end
			end
		end

		it "shows the 'Switch Turn' button after an attack was made" do
			should_not have_button 'Switch Turn'
			click_button 'A1'
			should have_button 'Switch Turn'
		end

		it "turns color of legend from grey to white after the 'Switch Turn' button is clicked" do
			click_button 'A1'		
			click_button 'Switch Turn'
			within "#play-grid" do
				should have_selector :xpath, '//input[@class="legend color-white"]', count: 21
				should have_selector :xpath, '//input[@class="legend color-grey"]', count: 0
			end
		end

		it "hides the 'Switch Turn' button after it's clicked" do
			click_button 'A1'
			click_button 'Switch Turn'
			should_not have_button 'Switch Turn'
		end
	end
end
