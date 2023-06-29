# Pong in C (Raylib)

$$
(230/100) + 2 + 3 = 7.30
$$

| LOC | Set Up | Writing | Score |
| --- | ------ | ------- | ----- |
| 230 | 2      | 3       | 7.30  |

This version of the "Pong spec" has been implemented in [C](https://en.wikipedia.org/wiki/C_(programming_language) using [Raylib](https://www.raylib.com/).

## Notes

Before starting this implementation I had anticipated that C would be a difficult language to pick up. This is not the case. I actually found the language itself to be quite easy to pick up. The main issue I had was understanding what a [pointer](https://www.geeksforgeeks.org/c-pointers/) is. This due is to the fact I have done very little low level programming. After an hour of reading and causing compile errors I started to get my head around the concept and was able to make good progress. This progress was helped by the Raylib game library.

Raylib states that it is a "programming library to enjoy videogames programming". I feel that it achieves this goal. The documentation is example based, which I found very easy to follow. It also has a great "[cheatsheet](https://www.raylib.com/cheatsheet/cheatsheet.html)" page. This is what I refered to whilst creating the pong implementation.

There was however a big impediment with this implementation. It took about an hour and a half to get the project to build with CMake. This may not be an issue for an experienced C dev. But for me coding in C for the first time, the developer experience around adding an external library was a nightmare. It turned out that the issue was caused by a reference to the wrong Raylib triplet. This took a lot of debugging and the error message I received when trying to build was not helpful.
