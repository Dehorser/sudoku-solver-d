import std.range : iota;

immutable static int SUDOKU_SIZE = 9;
immutable static int BLANK = 0;

class Sudoku {
    int[SUDOKU_SIZE][SUDOKU_SIZE] board;

    bool solve() {
        return solve(0, 0);
    }

    bool solve(size_t row, size_t col) {
        // If we are past the last value, we've successfully completed the
        // puzzle
        if (row >= SUDOKU_SIZE) {
            return true;

        // If the value isn't blank, then continue
        } else {

            // Get the index of the next value
            size_t new_row;
            size_t new_col;
            if (col + 1 >= SUDOKU_SIZE) {
                new_row = row + 1;
                new_col = 0;
            } else {
                new_col = col + 1;
            }

            // If it's not blank, then go solve the next value
            if (board[row][col] != BLANK) {
                return solve(new_row, new_col);

            // Else, try to fill in the blanks
            } else {
                foreach(v; 1..SUDOKU_SIZE + 1) {
                    if (check(row, col, v)) {
                        board[row][col] = v;
                        if (solve(new_row, new_col)) {
                            return true;
                        } else {
                            board[row][col] = BLANK;
                        }
                    }
                }
            }
        }

        // If nothing works, return false
        return false;
    }

    bool check(size_t row, size_t col) {
        return check(row, col, board[row][col]);
    }

    bool check(size_t row, size_t col, int v) {
        return check_row(row, col, v);
    }

    // Checks if a value is consistent with a given row
    bool check_row(size_t row, size_t col, int v) {
        foreach(i, n; board[row]) {
            if (n == v && i != col) {
                return false;
            }
        }
        return true;
    }

    bool check_col(size_t row, size_t col, int v) {
        return true;
    }

    // Assert that each number is a valid value and doesn't conflict with other
    // values
    invariant() {
        // Gets index of row and column, as well as individual value
        foreach(row_i, row; board) {
            foreach(col_i, n; row) {
                assert(n == BLANK || n in iota(1, SUDOKU_SIZE + 1, 1));
                assert(check(row_i, coli));
            }
        }
    }
}
