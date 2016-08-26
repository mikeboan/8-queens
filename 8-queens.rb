require 'colorize'

class EightQueens
  def self.empty_grid
    grid = Array.new(8) { Array.new(8) }
    grid [5][4] = 'Q'
    grid [7][6] = 'Q'
    grid
  end

  def solve(grid = EightQueens.empty_grid)

  end

  def has_error?(grid)
    row_error?(grid) || col_error?(grid) #|| diag_error?(grid)
  end

  def row_error?(grid)
    render(grid)
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
        q_count += 1 unless grid[row_num, col_num].nil?
      end
      return true if q_count > 1
      q_count = 0
    end
    false
  end

  def diag_error?(grid)
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

p EightQueens.new.has_error?(EightQueens.empty_grid)
