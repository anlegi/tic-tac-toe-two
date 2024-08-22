class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end

  def get_move
    puts "#{name}, enter your move (1-9)"
    gets.chomp.to_i #user input to integer
  end
end
