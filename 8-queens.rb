require 'colorize'
require 'byebug'

class EightQueens
  def self.empty_board
    board = Array.new(8) { Array.new(8) }
    # board[0][2] = "Q"
    # board[1][5] = "Q"
    # board[2][3] = "Q"
    # board[3][0] = "Q"
    # board[4][7] = "Q"
    # board[5][4] = "Q"
    # board[5][4] = "Q"
    # board[5][4] = "Q"
    # board[6][6] = "Q"
    board
  end

  def solve(board = EightQueens.empty_board, row = 0, col = 0)
    # debugger
    # return false if has_error?(board)
    return true if row > 7 ## solved!

    system('clear')
    render(board)
    # sleep(3.0)

    ## iterate over possibilities
    new_col = col + 1
    8.times do |new_row|
      # debugger
      if safe_pos?(board, new_row, new_col)
        place_queen(board, new_row, new_col)
        # debugger
        if solve(board, new_row, new_col)
          render(board)
          return true
        end

        remove_queen(board, new_row, col)
      end
    end

    ## return false if
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
      return true unless board[row][col].nil?
    end
    false
  end

  def safe_col?(board, col)
    8.times do |row|
      return true unless board[row][col].nil?
    end
    false
  end

  def safe_diags?(board, row, col)
    check_row = row
    check_col = col

    deltas = [[-1, 1], [1, 1] [-1, 1], [-1, -1]]
    deltas.each do |delta|
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

  def has_error?(board)
    row_error?(board) ||
      col_error?(board) ||
      diag_error?(board)
  end

  def row_error?(board)
    # debugger
    board.each do |row|
      q_count = 0
      row.each do |space|
        q_count += 1 unless space.nil?
      end
      return true if q_count > 1
      q_count = 0
    end
    false
  end

  def col_error?(board)
    # debugger
    board.each_with_index do |row, row_num|
      q_count = 0
      row.each_with_index do |space, col_num|
        q_count += 1 unless board[row_num][col_num].nil?
      end
      q_count = 0
    end
    false
  end

  def diag_error?(board)
    # debugger
    board.each_with_index do |row, row_num|
      row.each_with_index do |space, col_num|
        next if board[row_num][col_num].nil?
        deltas = [[-1, 1], [1, 1] [-1, 1], [-1, -1]]
        deltas.each do |delta|
          delta_row = delta.first
          delta_col = delta.last
          search_pos_row = row_num + delta_row
          search_pos_col = col_num + delta_col
          while search_pos_col.between?(0, 7) && search_pos_row.between?(0, 7)
            # debugger
            return true unless board[search_pos_row][search_pos_col].nil?
            search_pos_row += delta_row
            search_pos_col += delta_col
          end
        end
      end
    end
    false
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
p EightQueens.new.solve(board)
