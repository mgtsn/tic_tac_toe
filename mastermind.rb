class Mastermind
  @@COLORS = [0, 1, 2, 3, 4, 5]
  @@MAX_GUESSES = 8

  def initialize(code)
    @code = code
  end

  def check_guess(guess)
    @code == guess
  end

  def get_input
    guess = []
    4.times do |n|
      puts "Guess color number #{n + 1}"
      input = gets.chomp.to_i
      guess.push(input)
    end
    guess
  end

  def play
    guess_count = 1
    finished = false
    until finished or guess_count > @@MAX_GUESSES
      puts "Guess number #{guess_count}"
      input = get_input
      finished = check_guess(input)
      guess_count += 1
    end
    if finished
      puts "You win"
    else
      puts "You lose"
    end
  end
end

m = Mastermind.new([1, 2, 3, 4])

m.play
