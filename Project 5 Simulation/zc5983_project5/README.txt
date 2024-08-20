<project5> Report for <zc5983>
====================================

## Instructions

<Open zc5983_project5 in Processing and click Run. Click on any susceptible (grey) individual  to start the infection process. Use the scroll bars to adjust the infection rate and recovery rate. The 'Reset' button resets the grid to its initial state.>

## Report

<Narrative: 
	Disease Spread Simulation. Based on user-defined rates of infection and recovery, a disease can spread from one individual to another, and infected individual can recover.

Classes: 
	Button: Base class for button functionality.
	TextButton: Represents a button with text, subclass of Button class.
	ScrollBar: Represents a scroll bar for adjusting infection and recovery rates, subclass of Button class.
	Grid: Represents individuals with 3 states: susceptible (grey), infectious (red), removed/recovered (blue).

Interaction:
	Based on the infection rate, the disease may spread to neibouring individual. 
	Based on the recovery rate, infected individual may recover and become immune from the disease.  

Drawing Elements:
	Individuals are imported using PImage.

Unexpected Challenges:
	Ensuring the simulation starts only after user interaction (clicking a grid cell).
	Correctly implementing the infection and recovery process based on the rates adjusted by the scroll bars.
	Stopping the day counter when there are no more infectious cells to simulate the end of the outbreak.
behavior.
	Decoupling the frontend and backend to separate the simulation logic from the rendering.

Extra Credit Implementation:
	Simulation Speed Control: Used millis() function within the simulation loop to delay if the simulation step completes too quickly.
	Separate Threads: Used the thread() function to run the simulation logic on a separate thread from the rendering loop.

Assistance
	Used ChatGPT to write this report.>