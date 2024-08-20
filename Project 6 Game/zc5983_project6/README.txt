<project6> Report for <zc5983>
====================================

## Instructions

<Open zc5983_project6 in Processing and click Run. Play the Breakout game.>

## Report

<Rules: 
	The ball bounces off the walls and the player's paddle.
	The ball breaks bricks upon contact, 3 points per brick.
	The ball goes quicker as more bricks are broken. There is a maximum speed. 
	The player loses a life if the ball falls off the bottom of the screen.

Controls:
	Mouse movement controls the paddle's horizontal position.
	Press the button to start/pause/restart (if the player loses or break all the bricks) the game.

Classes: 
	GameObject: Abstract base class for all game objects, managing common properties like position, visibility, and collisions.
	Ball: Handles ball dynamics including movement, collision detection with the paddle and bricks.
	Bar: Tracks and updates the paddle's position based on the mouse's x-coordinate, constraining it within the game boundaries.
	Brick: Represents individual bricks, handling their visibility and redrawing them only if they have not been hit.
	Button and TextButton: Manages GUI elements such as buttons for pausing, starting, and restarting the game. `TextButton` is a subclass that additionally displays text on the buttons.

Unexpected Challenges:
	Collision Detection: Ensuring accurate collision detection between the ball and the bricks was challenging, especially when the ball hit the edge of a brick.
	Game State Management: Properly managing game states (such as paused, running, and game over states) to respond to player interactions through GUI elements.
	Performance Optimization: Keeping the game running smoothly as the number of elements (like bricks and GUI components) increased.

Assistance
	Used ChatGPT to write this report.>