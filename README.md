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



**Contact me:**
Please write your feedback and suggestions to joshi.ajay@gmail.com
If you come across any Sudoku problem which is not solved by this program please send it across to me.
