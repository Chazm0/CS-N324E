<Final Project> Report for <zc5983>
====================================
Groups:
	I worked alone on this project. 

Rules:
	Eliminate all pigs with the least number of birds.
	The pigs die if they touch the ground or the bird
	Each eliminated pig = 100 points; Each surviving bird = 100 points.
	Game lost if there are surviving pigs, no surviving birds, and all motion stopped (velocity of every objects lower than a threshold).

Control:
	Select Level 1 or Level 2 in the main menu. 
	Drag the catapult to launch the bird. 
	After a bird is launched, click the standby bird to load it on the catapult.
	For the yellow bird, press Space to accelerate. 
	Click the pause button to stop/play the background music.
	Click the reset button to reset the current level.
	Click the main menu button to return to main menu.

Classes: 
	p.s. Used the fisica library for physics. Most of my classes are subclasses of FCircle/FBox from fisica.  
	Class Bird extends FCircle. It takes in 1 parameter, birdType, which can be either red or yellow. It has accelerate() method, which will be called if birdType == yellow. 
	Class Brick extends FBox. It takes in 1 parameter, brickType, which can be stone, wood, or glass. Each have different color and density.
	Class Button. Allows for either circular or rectangular buttons. 
	Class Catapult. It draws the catapult and sets it physically transparent using setSensor(true), a fisica method. 
	Class Pig extends FCircle. It creates a pig that dies if it touches the ground or the bird. 

Data input/output: 
	The highest scores for each level are stored in scores.txt and displayed on the main level screen.
	The angry bird font, angrybirds-regular.ttf, is loaded using PFont. 
	The background music, Main_Theme.mp3, is loaded using the Minim library. 

Unexpected Challenges:
	Initially tried to create a physics engine by scratch. Managed to get the most basic physics working (circle vs circle, box vs box, circle vs box), but got stuck at angular rotation/velocity for box vs box and circle vs box. Eventually gave up and switched to fisica. 
	Resetting the bricks and pigs for each level was buggy. Since Level 1 has 10 bricks and 2 pigs and Level 2 has 8 bricks and 4 pigs, I had to initialize bricks and pigs to "air", which don't have any physics property. Strange bug triggers when I swtich level, which Kevin and me spent 30 mins after class and failed to solve. Kevin later suggests I should initialize the bricks and pigs level by level, which eventually solved the problem. 

Assistance:
	Used ChatGPT to debug and generate starter code. 
	Used fisica library for physics. 
	Used Minim library to play/pause audio. 
