# Pong in ...

[Pong](https://en.wikipedia.org/wiki/Pong) implemented in various programming languages and frameworks.

Each implementation will be ranked in terms of ease of use. Ease of use will be determined by time to set up environment in hours, hours taken to write the necessary code, and lines of code written. These criteria will then be quantified using the following formula.

$$
(loc/100) + setup + writing
$$

## Results

| Language   | Library           | LOC | Set Up | Writing | Score (Lower Better) |
| ---------- | ----------------- | --- | ------ | ------- | -------------------- |
| Python     | Pygame            | 164 | .5     | 1.5     | 3.64                 |
| Javascript | None (Canvas API) | 216 | 0      | 2       | 4.16                 |

### Why?

The goal of this project is compare programming languages in a naive manner. Focusing on the given programming language's ease of use. Pong, as a relatively simple and well known program, has been selected as a comparator.

### Is programming experience and skill taken into consideration?

Yes, it should be noted that the programmer implementing the below Pong spec is a Javascript programmer with 10 years programming experience.

This means that the [Javascript (Canvas API)](https://github.com/coneonthefloor/pong-in/tree/master/javascript/canvas-api/README.md) implementation should be used as a benchmark. The aforementioned implementation scores a `4.16` ($(216/100) + 0 + 2$). Note that time to setup is zero here as Javascript is built into web browsers.

## The Pong Spec

All implementations of Pong will be written to the below spec. The spec describes an "endless" Pong game, where two paddles will play against each other indefinitely.

_Note:_ The goal is not to create the best engineered version of the spec. But rather to implement the spec via the path of least resistance.

- should have a screen size of 640px width by 480px height
- should render a black background
- should draw white dashed line down center of screen
- should begin game on load

- Ball

  - should have a ball of 10px radius
  - should initially place ball in center of screen
  - should render ball as a white circle
  - should initially give ball an x velocity of minus or negative ball speed
  - should initially give ball a y velocity of minus or negative ball speed / 2
  - should reset ball speed and set position to center of screen after it exits screen
  - should propel ball downwards when it hits the top of the screen
  - should propel ball upwards when it hits the bottom of the screen

- Paddles

  - should have two paddles of 10px width by 100px height
  - should initially set paddle in vertical center of screen
  - should place left paddle with 20px gap from the left of the screen
  - should place right paddle with 20px gap from the right of the screen
  - should render paddle as a white rectangle
  - should move left paddle towards ball's y value when ball is travelling left
  - should move right paddle towards ball's y value when ball is travelling right
  - should move left paddle towards the screen's vertical center when ball is travelling right
  - should move right paddle towards the screen's vertical center when ball is travelling left
  - should contain paddle fully within vertical bounds

- Ball collides with Paddle

  - should increment ball speed
  - should propel ball leftwards when it hits the right paddle
  - should propel ball rightwards when it hits the left paddle
  - should give ball a y velocity of ball speed / 2 when a paddle is hit and the ball has a negative y velocity
  - should give ball a y velocity of minus ball speed / 2 when a paddle is hit and the ball has a positive y velocity

- Score
  - should render score with white 20px monospace font
  - should render score centered and 20px from top of screen
  - should render left paddle's score to left of the dashed line
  - should render right paddle's score to right of the dashed line
  - should award right paddle one point when ball exits screen to left
  - should award left paddle one point when ball exits screen to right
