#Battleships: Web Version

##Makers Academy | Week 6 | Challenge


## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
* [Guidelines](#guidelines)
* [How to Play](#how-to-play)
* [See it Live on Heroku](#see-it-live-on-heroku)
* [Browsers](#browsers)
* [Testing](#testing)
* [License](#license)


##Screenshots

<table>
	<tr>
		<td align="center" width=25%>
			<a href="https://raw.githubusercontent.com/nadavmatalon/battleships_web/master/public/images/battleships_web_1.jpg">
				<img src="public/images/battleships_web_1.jpg" height="92px" />
				 Start
			</a>
		</td>
		<td align="center" width=25%>
			<a href="https://raw.githubusercontent.com/nadavmatalon/battleships_web/master/public/images/battleships_web_2.jpg">
				<img src="public/images/battleships_web_2.jpg" height="92px" />
				 Setup
			</a>
		</td>
		<td align="center" width=25%>
			<a href="https://raw.githubusercontent.com/nadavmatalon/battleships_web/master/public/images/battleships_web_3.jpg">
				<img src="public/images/battleships_web_3.jpg" height="92px" />
				Play
			</a>
		</td>
		<td align="center" width=25%>
			<a href="https://raw.githubusercontent.com/nadavmatalon/battleships_web/master/public/images/battleships_web_4.jpg">
				<img src="public/images/battleships_web_4.jpg" height="92px" />
				Winner
			</a>
		</td>
	</tr>
</table>


##General Description

This repo contians my answer to __Week 6 Friday Challange__ as part 
of the course at [Makers Academy](http://www.makersacademy.com/).

The first working iteration of this app was written over a weekend, 
and in later iterations I've refactored both the back-end logic 
and front-end interface.

The app consists of the game of __Battleships__ written in 
[Ruby](https://www.ruby-lang.org/en/) &amp; 
[JavaScript](http://en.wikipedia.org/wiki/JavaScript) 
according to [TDD](http://en.wikipedia.org/wiki/Test-driven_development) 
(testing with [Rspec](http://rspec.info/) &amp; 
[Capybara](https://github.com/jnicklas/capybara)).

For more information about the game see: 
[Wikipedia on Battleships](http://en.wikipedia.org/wiki/Battleship_(game))


##Guidelines

* The task is to write a web based battleship game in 
  [Sinatra](http://www.sinatrarb.com/) using your knowledge and googling skills
* When a potential player goes to the website the player will be prompted for a 
  name to register for a new game (only if there are less than two players already 
  registered)
* Once registered you will be able to place your ships (you will need to show a 
  grid and allow the players to place their ships on it; the types and numbers of 
  ships allowed are the same for each player)
* After the ships have been positioned, the game proceeds in a series of rounds. 
  In each round, each player takes a turn to announce a target square in the 
  opponent's grid which is to be shot at. The opponent announces whether or not 
  the square is occupied by a ship, and if it is a "hit" they mark this on their 
  own primary grid. The attacking player notes the hit or miss on their own 
  "tracking" grid, in order to build up a picture of the opponent's fleet
* When all of the squares of a ship have been hit, the ship is sunk, and the ship's 
  owner announces this (e.g. "You sank my battleship!"). If all of a player's 
  ships have been sunk, the game is over and their opponent wins
* You will get extra credit if the game looks beautiful
* If you want a challenge over the challenge (we haven’t covered any of this): 
  Deploy your sinatra application on [Heroku](http://www.heroku.com/)


##How to Play

The game of __Battleships__ is typically played with 2 players.

The goal of each player is to be the first to sink all of the other player's ships. 

The game begins with each player setting up their own board with a collection of 10 ships of
different kinds (and without letting the other player peak!)

Each player set of ships consists of:

* 1 x __Battleship__        (covers 4 squares)
* 2 x __Cruisers__          (each covering 3 squares)
* 3 x __Destroyers__        (each covering 2 squares)
* 4 x __Submarines__        (each covering 1 square)

Each ship must be placed either in a vetical or horizontal position.

(additional on-screen instructions are given regarding placement of ships on the board)

After the boards are set, the players take turns  attacking a single 
coordinate (square) on the other player's board in each turn, so as
to try and hit the other player's ships. 

(on-screen instructions are also given on how to attack the other player's ships)

If the attack is successful the game issues a 'ship hit' message.

When all the coordinates of a given ship are hit, it sinks and the game issues a 
'ship sunk' message (it will also remove that ship from the other player's ship list
so players can keep track of how many ships each player has at any given moment).

The player who manages to sink all of the other player's ships is the winner.


##See it Live on Heroku

A live version of the app can be found at:

[Battleships on Heroku](http://battleships-web.herokuapp.com)

As I'm using Heroku's free hosting service, the app may take a bit of time 
to upload<br/>
(Heroku's giros take time to wake up...), so please be patient.


##Browsers

For the best user experience, please use:

* __Mozilla Firefox__ (31.0 or later)

The app was also tested on:

* __Apple Safari__ (7.0.5)

* __Google Chrome__ (36.0)

However these browsers may show flickering on transitions.


##Testing

Tests were written with [Rspec](http://rspec.info/) (3.0.4) &amp; 
[Capybara](https://github.com/jnicklas/capybara) (2.4.1).

The tests cover both back-end logic and front-end functionality.

To run the tests in terminal: 

```bash
$> ch battleships_web
$> rspec
```


##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

