#Battleships: Web Version

## Table of Contents

* [Screenshots](#screenshots)
* [General Description](#general-description)
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

The game of __Battleships__ written in [Ruby](https://www.ruby-lang.org/en/) and [JavaScript](http://en.wikipedia.org/wiki/JavaScript) according to [TDD](http://en.wikipedia.org/wiki/Test-driven_development) (testing with [Rspec](http://rspec.info/) and [Capybara](https://github.com/jnicklas/capybara)).

For more information about the game see: [Wikipedia on Battleships](http://en.wikipedia.org/wiki/Battleship_(game))


##How to Play

The game of __Battleships__ is typiclly played with 2 players.

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

http://battleships-web.herokuapp.com

As I'm using Heroku's free hosting service, the app may take a bit of time to upload<br/>
(Heroku's giros take time to wake up...), so please be patient.


##Browsers

For the best user experience, please use:

* __Mozilla Firefox__ (31.0 or later)

The app was also tested on:

* Apple Safari (7.0.5)

* Google Chrome (36.0)

However these browsers may show flickering on transitions.


##Testing

Tests were written with [Rspec](http://rspec.info/) (3.0.4) and [Capybara](https://github.com/jnicklas/capybara) (2.4.1).

The tests cover both back-end logic and front-end functionality.

To run the tests in terminal: 

~~~ bash
$> ch battleships_web
$> rspec
~~~


##License

<p>Released under the <a href="http://www.opensource.org/licenses/MIT">MIT license</a>.</p>

