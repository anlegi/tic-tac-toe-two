class Board
  def initialize
    @grid = Array.new(3) { Array.new(3, " ") }  # 3x3 grid initialized with empty spaces
  end

  def display
    @grid.each { |row| puts row.join(" | ")} # joins each row's elements with |
  end

  def place_move(row, col, marker)
    @grid[row][col] = marker if @grid[row][col] == " " #place marker if spot is empty
  end

  def rows
    @grid.any? { |row| row.uniq.size == 1 && row.first != " " } # iterate over each row in the grid
    #removes duplicates, if all elements are the same, the size will be 1
    #.first checks if first element is not empty
  end

  def columns
    @grid.transpose.any? { |col| col.uniq.size == 1 && col.first != " " }
    #.transpose converts rows to columns
  end

  def diagonals
    [@grid, @grid.map(&:reverse)].any? do |g|
      [g[0][0], g[1][1], g[2][2]].uniq.size == 1 && g[1][1] != " "
      # .map(&:reverse) calls reverse method on each element of an array
      # @grid original grid and the other is mirrored grid
      # .uniq checks if elements in the diagonal are the same and not empty
    end
  end

  def winner?
    rows || columns || diagonals # wins if any are true
  end
end
