immutable static int SUDOKU_SIZE = 9;
immutable static int BLANK = 0;

class Sudoku {
    int[SUDOKU_SIZE][SUDOKU_SIZE] board;

    invariant{
        import std.range : iota;
        foreach(immutable ref row; board) {
            foreach(immutable ref n; row) {
                // Assert that each number is either blank or a valid value
                assert(n == BLANK || n in iota(1, SUDOKU_SIZE + 1, 1));
            }
        }
    }
}
