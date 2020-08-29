class Board
  @@board_count = 0
  @@POSSIBLE_WINS = [["0", "1", "2"], ["0", "1", "2"], ["0", "1", "2"], ["0", "1", "2"], ["0", "1", "2"],
                     ["0", "1", "2"], ["0", "1", "2"], ["0", "1", "2"], ["0", "1", "2"]]

  def initialize
    @game_finished = false
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

  def get_input
    input_found = false
    until input_found
      puts "Enter a number from 1-9: "
      input = gets.chomp.to_i
      if input.between?(1, 9)
        if @squares[input - 1] == "_"
          input_found = true
        end
      end
    end
    return input
  end

  def turn
    print_board
    puts "#{@player}'s turn"
    input = get_input
    @squares[input - 1] = @player
    switch_player
  end

  def check_for_winner
    return @squares[8] != "_"

    @@POSSIBLE_WINS.each do |row|
      p row
    end
  end

  public

  def play
    until @game_finished
      turn
      @game_finished = check_for_winner
    end
    print_board
  end
end

b = Board.new()

b.play
