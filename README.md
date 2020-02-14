# Find Dense in Grid Code Challange - Swift

This code challange is solved in Swift. However, it can be written in any programming languages.


The input is in the form of a list of numbers of the form:

```t n Grid```

```1 3 4 2 3 2 2 1 3 2 1```

Where `t` is the number of results requested, `n` is the size of the grid and grid is a space delimited list of numbers that form the grid, starting with row 0.

The list of numbers above therefore represent a request for the top score from a 3x3 grid that looks like so:

|			| 			|			|
|---------|---------|---------|
|4			|2			|3			|
|2			|2			|1			|
|3			|2			|1			|

In the above grid, for instance, the score for row 1 and column 1 is:

4 + 2 + 3 + 2 + 3 + 2 + 1 +1 + 2 = 20

For the edge cell of row 0 and column 0 the score is euqal to:

2 + 2 + 2 + 4 = 10---The result format is as follows:
```(x, y, score: score)```

i.e. the result that should be returned for the above input is:```
(1, 1, score: 20)
```

## Test cases

### Test 1```1 5 5 3 1 2 0 4 1 1 3 2 2 3 2 4 3 0 2 3 3 2 1 0 2 4 3```

Expected output:```
(3, 3 score:26)
```

### Test 2```3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4```

Expected output:```
(1, 2 score: 27)
(1, 1 score: 25)
(2, 2 score: 23)
```

## Author
Soheil Novinfard - [www.novinfard.com](https://www.novinfard.com)

## License
This project is licensed under the MIT.