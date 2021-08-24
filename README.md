# sudokuolver
**Introduction:**
Sudoku Solver is a command line utility which will solve 9 x 9 Sudoku problems for you.
This program is developed in Perl.

**Usage:**
sudoku_solver.pl matrix.csv

If you want to know in which sequence the numbers are found, use following command:
sudoku_solver.pl matrix.csv –details
This option will give you the result like:
Number Found: 2 [4] [1] [3] > row uniqueness
The individual squares are numbered from 1 to 9 starting left to right. The rows and columns are numbered for each individual square from 1 to 3 each
Hence, it says number 2 found in 4th square and 1st row and 3rd column

csv file format:
The data file is a comma separated file containing 9 x 9 data.
Replace the blank numbers with zeros and save the file in csv format.
e.g. A typical Sudoku solver would look like:

0	0	8	0	1	0	0	0	0

0	0	0	0	0	5	6	0	9

1	0	7	0	0	0	0	4	0

0	0	0	0	0	0	0	9	4

0	1	9	0	2	0	3	5	0

7	8	0	0	0	0	0	0	0

0	7	0	0	0	0	4	0	1

3	0	6	8	0	0	0	0	0

0	0	0	0	9	0	5	0	0

**Sample output:**
C:\Perl scripts\sudokusolver>sudoku_solver.pl matrix.csv -details


Author: Ajay Joshi, email: joshi.ajay@gmail.com


Total digits found: 36

Iteration 1

Number found: 1 [1] [1] [3] > square uniqueness

Number found: 1 [2] [2] [3] > square uniqueness

Number found: 1 [5] [2] [1] > square uniqueness

Number found: 1 [6] [3] [3] > square uniqueness

Number found: 3 [1] [2] [1] > square uniqueness

Number found: 3 [6] [2] [1] > square uniqueness

Number found: 3 [8] [1] [2] > square uniqueness

Number found: 3 [9] [2] [2] > square uniqueness

Number Found: 3 [4] [1] [3] > row uniqueness

Number found: 4 [7] [1] [2] > square uniqueness

Number found: 4 [9] [3] [1] > square uniqueness

Number found: 5 [3] [3] [2] > square uniqueness

Number found: 5 [8] [3] [1] > square uniqueness

Number found: 5 [9] [1] [1] > square uniqueness

Number Found: 5 [4] [3] [1] > row uniqueness

Number found: 5 [6] [2] [3] > column uniqueness

Number found: 6 [4] [2] [3] > square uniqueness

Number found: 6 [8] [2] [1] > square uniqueness

Number Found: 6 [1] [2] [2] > row uniqueness

Number Found: 6 [2] [3] [2] > row uniqueness

Number Found: 6 [5] [3] [3] > row uniqueness

Number found: 7 [3] [2] [3] > square uniqueness

Number found: 7 [7] [3] [3] > square uniqueness

Number found: 7 [8] [1] [3] > square uniqueness

Number Found: 7 [1] [1] [1] > row uniqueness

Number Found: 7 [2] [3] [1] > row uniqueness

Number Found: 7 [5] [1] [2] > row uniqueness

Number found: 8 [5] [2] [3] > square uniqueness

Number Found: 8 [4] [1] [1] > row uniqueness

Number Found: 8 [9] [3] [3] > row uniqueness

Number found: 8 [1] [3] [3] > column uniqueness

Number found: 9 [2] [1] [3] > square uniqueness

Number found: 9 [3] [2] [2] > square uniqueness

Number found: 9 [5] [1] [1] > square uniqueness

Number found: 9 [6] [3] [1] > square uniqueness

Number found: 9 [9] [2] [3] > square uniqueness

Number found: 2 [1] [3] [2] > square uniqueness

Number found: 2 [3] [1] [1] > square uniqueness

Number found: 2 [5] [2] [2] > square uniqueness

Number found: 2 [6] [1] [3] > square uniqueness

Number found: 2 [7] [2] [1] > square uniqueness

Number found: 2 [9] [1] [2] > square uniqueness

Number found: 4 [4] [2] [1] > square uniqueness

Number found: 4 [5] [3] [2] > square uniqueness

Number found: 8 [7] [2] [2] > square uniqueness

Done! Answer found in just 1 iterations!!


Numbers remaining: 0

Data file: matrix.csv:

Below is the final answer:

7	5	1	4	8	9	2	6	3	

3	6	4	2	5	1	8	9	7	

9	2	8	7	6	3	1	5	4	

8	1	3	9	7	5	6	4	2	

4	9	6	1	2	8	3	7	5	

5	7	2	3	4	6	9	8	1	

1	4	9	8	3	7	5	2	6	

2	8	5	6	1	4	7	3	9	

6	3	7	5	9	2	4	1	8	


C:\Perl scripts\sudokusolver>

End of sample output

**Contact me:**
Please write your feedback and suggestions to joshi.ajay@gmail.com
If you come across any Sudoku problem which is not solved by this program please send it across to me.
