Temporary Russian Pirates
=========================

Ship
----
	- knows if it is hit or not
	- knows how many hits it has received so far
	- has status: knows if it is sunk or floating
	- has properties (size [aka name of the ship], location)

Board
-----
	- knows what ships it has
	- knows the status of each ship
	- knows when no more ships
	- responsible for informing game that there are no more ships
	- has size/dimensions (aka range A1..J10)
	- has to inform opponent's board about each hit


Person
------
	- can ask the board to place ships
	- call hits on opponent's board

Rules
-----
	- One player can have ten ships :
		 1 battleship (size 4)
		 2 cruisers (size 3)
		 3 destroyers (size 2)
		 4 submarine (size 1)
	- The ships cannot be placed on another ship
	- The ships must be placed inside the dimensions of the Board
	- When all the segment of the ship are hit, the ship sinks

	###Extensions
		- Ships cannot be placed adjacent to one another

Game
----
	- Initialises the game
	- A player can call one hit attempt at one time
	- Turn then passes to next player
	- The first player that makes all the other player's ships sink, wins the game