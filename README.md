# Dominoes Square Riddle Solver
This repository contains a dominoes riddle solver written in Prolog implemented in optimal
(hopefully) time and space complexity. This was the last problem set in Programming Languages
course at NTUA in 2017.

## Problem Description
Dominoes are rectangular tiles with each rectangle dividing its face into two square ends and
each end is marked with zero to six spots. There are 28 distinct dominoes which we represent
with numbers as (0,0),(0,1),(0,2), ..., (0,6),(1,1),(1,2),...,(5,6),(6,6).

We are presented with an input of an 8x7 matrix consisted of 56 integer numbers from zero to six
and we are tasked to find the number of different tiles placements in such a way that all 56
numbers are "covered". Two examples are presented below:
```
?- dominos('square1.txt', N).
N = 1.
?- dominos('square2.txt', N).
N = 18.
```

```
> cat square1.txt
5 3 1 0 0 1 6 3
0 2 0 4 1 2 5 2
1 5 3 5 6 4 6 4
0 5 0 2 0 4 6 2
4 5 3 6 0 6 1 1
2 3 5 3 4 4 5 3
2 1 1 6 6 2 4 3
```

```
> cat square2.txt
0 3 0 2 2 0 2 3
1 5 6 5 5 1 2 2
3 4 1 4 5 4 4 4
6 6 1 0 5 2 3 0
4 0 3 2 4 1 6 0
1 4 1 5 6 6 3 0
1 2 6 5 5 6 3 3
```

### Requirements
The program was tested on SWI-Prolog so I suggest you download it from your terminal:
`sudo apt-get install swi-prolog-nox`
### Usage example
```
$ swipl
Welcome to SWI-Prolog (threaded, 64 bits, version 7.6.4)
SWI-Prolog comes with ABSOLUTELY NO WARRANTY. This is free software.
Please run ?- license. for legal details.

For online help and background, visit http://www.swi-prolog.org
For built-in help, use ?- help(Topic). or ?- apropos(Word).

?- [dominos].
true.

?- dominos('testcases/square1.txt', N).
N = 1.

?- dominos('testcases/square2.txt', N).
N = 18.
```
