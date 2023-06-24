# Pong in ...

[Pong](https://en.wikipedia.org/wiki/Pong) implemented in various programming languages and frameworks.

## The Pong Spec

 - should have a screen size of 640px width by 480px height
 - should render a black background
 - should render all game objects using white color
 - should render score text for each paddle on screen
 - should draw dashed line down center of screen
 - should begin game on load
 
 - Paddles
  - should have two paddles of 20px width by 100px height
  - should initially set paddle in vertical center of screen
  - should place left paddle with 20px gap from the left of the screen
  - should place right paddle with 20px gap from the right of the screen
  - should contain paddle fully within vertical bounds
  - should move left paddle towards ball's y value when ball is travelling left
  - should move right paddle towards ball's y value when ball is travelling right
  - should move left paddle towards the screen's vertical center when ball is travelling right
  - should move right paddle towards the screen's vertical center when ball is travelling left
 
 - Ball
  - should have a ball of 10px radius
  - should initially place ball in center of screen
  - should reset ball to center of screen after it exits screen
  - should award right paddle one point when ball exits screen to left
  - should award left paddle one point when ball exits screen to right
  - should initially give ball an x velocity of minus or negative ball speed 
  - should initially give ball a y velocity of minus or negative ball speed / 2
  - should propel ball leftwards when it hits the right paddle
  - should propel ball rightwards when it hits the left paddle
  - should give ball a y velocity of minus or negative ball speed / 2 when a paddle is hit
  - should propel ball downwards when it hits the top of the screen
  - should propel ball upwards when it hits the bottom of the screen

- Score
  - should render score with 20px monospace font
  - should render score centered and 20px from top of screen
  - should render left paddle's score to left of the dashed line
  - should render right paddle's score to right of the dashed line