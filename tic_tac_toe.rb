class Board
  @@board_count = 0
  @@POSSIBLE_WINS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7],
                     [2, 5, 8], [0, 4, 8], [2, 4, 6]]

  def initialize
    @winner = "in progress"
    @player = "x"
    @squares = []
    9.times do
      @squares.push("_")
    end
    @@board_count += 1
  end

  private

  #Changes active player
  def switch_player
    if @player == "x"
      @player = "o"
    else
      @player = "x"
    end
  end

  #displays the current state of the board
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

  #gets input from user, makes sure it is in the correct range and that the box is not already filled
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

  #One player's turn: get input and add it to the board
  def turn
    print_board
    puts "#{@player}'s turn"
    input = get_input
    @squares[input - 1] = @player
    switch_player
  end

  #checks if a player has won yet
  def check_for_winner
    @@POSSIBLE_WINS.each do |row|
      if @squares[row[0]] == @squares[row[1]] and @squares[row[1]] == @squares[row[2]] and @squares[row[0]] != "_"
        return "#{@squares[row[0]]} wins!"
      end
    end
    unless @squares.include? "_"
      return "tie"
    end
    return "in progress"

    @@POSSIBLE_WINS.each do |row|
      p row
    end
  end

  public

  def play
    while @winner == "in progress"
      turn
      @winner = check_for_winner
      puts @winner
    end
    print_board
    puts @winner
  end
end

b = Board.new()

b.play
