require 'colorize'
require 'byebug'

class EightQueens
  def self.empty_grid
    grid = Array.new(8) { Array.new(8) }
  end

  def solve(grid = EightQueens.empty_grid, row = 0, col = 0)
    return false if grid.has_error?
    return true if row > 7 ## solved!

    ## iterate over possibilities


  end

  def has_error?(grid)
    row_error?(grid) || col_error?(grid) || diag_error?(grid)
  end

  def row_error?(grid)
    grid.each do |row|
      q_count = 0
      row.each do |space|
        q_count += 1 unless space.nil?
      end
      return true if q_count > 1
      q_count = 0
    end
    false
  end

  def col_error?(grid)
    grid.each_with_index do |row, row_num|
      q_count = 0
      row.each_with_index do |space, col_num|
        q_count += 1 unless grid[row_num][col_num].nil?
      end
      q_count = 0
    end
    false
  end

  def diag_error?(grid)
    grid.each_with_index do |row, row_num|
      row.each_with_index do |space, col_num|
        deltas = [[-1, 1], [1, 1] [-1, 1], [-1, -1]]
        deltas.each do |delta|
          delta_row = delta.first
          delta_col = delta.last
          search_pos_row = row_num + delta_row
          search_pos_col = col_num + delta_col
          while search_pos_col.between?(0, 7) && search_pos_row.between?(0, 7)
            return true unless grid[search_pos_row][search_pos_col].nil?
            search_pos_row += delta_row
            search_pos_col += delta_col
          end
        end
      end
    end
    false
  end

  def render(grid)
    system("clear")
    puts "           8 QUEENS"
    print "   "
    ('a'..'h').each { |letter| print " " + letter + " " }
    puts
    grid.each_with_index do |row, row_num|
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

p EightQueens.new.solve(EightQueens.empty_grid)
