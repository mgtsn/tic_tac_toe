class Board
  @@board_count = 0

  def initialize
    @player = "x"
    @squares = []
    9.times do
      @squares.push("_")
    end
    @@board_count += 1
  end

  def switch_player
    if @player == "x"
      @player = "o"
    else
      @player = "x"
    end
  end

  public

  def print_board
    count = 0
    3.times do
      3.times do
        print @squares[count] + " "
        count += 1
      end
      puts "\n"
    end
  end

  def turn(num)
    print_board
    puts "#{@player}'s turn:"
    input = gets.chomp
    puts input
    @squares[num] = @player
    switch_player
  end

  def check_for_winner
    if @squares[8] == "_"
      return "playing"
    else
      return "done"
    end
  end

  def play
    count = 0
    game = "playing"
    while game == "playing"
      turn(count)
      count += 1
      game = check_for_winner
    end
    print_board
  end
end

b = Board.new()

b.play
