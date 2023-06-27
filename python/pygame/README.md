# Pong in Python (Pygame)

$$
(164/100) + .5 + 1.5 = 3.64
$$

| LOC | Set Up | Writing | Score |
| --- | ------ | ------- | ----- |
| 164 | .5     | 1.5     | 3.64  |

This version of the "Pong spec" has been implemented in [Python](https://www.python.org/) using the [Pygame](https://www.pygame.org/news) library.

## Notes

I have never developed anything in Python before. So it is a shock to me that it took only 90 minutes to write this pong game.
The Pygame library is very intuitive and the docs are extensive. The most difficult part of the implementation was creating the "dashed" lines in the center of the screen. This is because I had to generate each line.

The only "gotcha" I had with the Python language was that adding properties to the `class` inline creates a static value. This lead to some weird behaviour with the paddles.

Despite this I was able to write code fluently and concisely from the get go. Leading to a fantastic score of `3.64`.
