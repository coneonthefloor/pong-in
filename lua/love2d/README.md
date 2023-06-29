# Pong in Lua (Love2D)

$$
(1.86/100) + .5 + 2 = 4.36
$$

| LOC  | Set Up | Writing | Score |
| ---- | ------ | ------- | ----- |
| 1.86 | .5     | 2       | 4.36  |

This version of the "Pong spec" has been implemented in [Lua](https://www.lua.org) using [Love2D](https://love2d.org).

## Notes

When I see Lua mentioned online, it is usually in relation to game development. In fact my initial introduction to Lua was through [Harvard's CS50 Game Development](https://cs50.harvard.edu/games/2018/) classes. Theses classes used Love2D to implement various retro games, introducing a new concept with each.

Having spent the last 2 hours writing Lua I can see why it is an appealing language. My perception is that it is a no-fuss simple language. A get things done quickly language. This is a good thing.

The Love2D game library has excellent documentation. I was able to search through it and find an answer to any question I had within seconds. I look forward to writing a more substantial game using Love2D.

One let down of Lua seems to be IDE support. Whilst writing this implementation the main drawback I had was that I was getting no feedback from my IDE on whether or not I had passed the correct params to a function or whether or not I had a syntax error. For example I would write `&&`, which is a syntax error in Lua as it uses `and`, but not recieve any feedback untill running the program. Perhaps this is easily solved by integrating various plugins. But I am unsure which to add as most "Lua" plugins seem to have a low install count.
