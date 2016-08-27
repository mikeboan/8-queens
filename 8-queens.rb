require 'colorize'

class EightQueens
  def self.empty_board
    board = Array.new(8) { Array.new(8) }
  end

  def solve(board = EightQueens.empty_board, row = 0, col = 0)
    return true if col > 7 ## solved!

    system('clear')
    render(board)
    sleep(0.1)

    ## iterate over possibilities
    8.times do |new_row|
      if safe_pos?(board, new_row, col)
        place_queen(board, new_row, col)
        if solve(board, new_row, col + 1)
          render(board)
          return true
        end
        remove_queen(board, new_row, col)
      end
    end

    ## return false if solution not found
    false
  end

  def place_queen(board, row, col)
    board[row][col] = "Q"
  end

  def remove_queen(board, row, col)
    board[row][col] = nil
  end

  def safe_pos?(board, row, col)
    safe_row?(board, row) &&
      safe_col?(board, col) &&
      safe_diags?(board, row, col)
  end

  def safe_row?(board, row)
    8.times do |col|
      return false unless board[row][col].nil?
    end
    true
  end

  def safe_col?(board, col)
    8.times do |row|
      # debugger
      return false unless board[row][col].nil?
    end
    p "safe_col"
    true
  end

  def safe_diags?(board, row, col)
    deltas = [[-1, 1], [1, 1], [1, -1], [-1, -1]]
    deltas.each do |delta|
      check_row = row
      check_col = col
      delta_row = delta.first
      delta_col = delta.last
      while check_row.between?(0, 7) && check_col.between?(0, 7)
        return false unless board[check_row][check_col].nil?
        check_row += delta_row
        check_col += delta_col
      end
    end
    true
  end

  def render(board)
    system("clear")
    puts "           8 QUEENS"
    print "   "
    ('a'..'h').each { |letter| print " " + letter + " " }
    puts
    board.each_with_index do |row, row_num|
      print " " + (8 - row_num).to_s + " "

      row.each_with_index do |piece, col_num|
        ## highlight selected piece
        if piece.nil?
          p_string = "   "
        else
          p_string = " Q ".colorize(:blue)
        end

        # determine background color
        if row_num.even? ^ col_num.even?
          background = :white#:light_black
        else
          background = :light_white
        end

        print p_string.colorize(:background => background)
      end
      puts ""
    end
  end
end

board = EightQueens.empty_board
queens =  EightQueens.new.solve(board)
# queens.safe_pos?(board,
