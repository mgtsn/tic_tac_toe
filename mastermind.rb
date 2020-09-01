class Mastermind
  @@COLORS = ["RED", "BLUE", "GREEN", "YELLOW", "BLACK", "WHITE"]
  @@MAX_GUESSES = 8

  def generate_code
    a = []
    4.times do
      a.push(@@COLORS.sample)
    end
    a
  end

  def initialize(code)
    @code = generate_code
  end

  def check_guess(guess)
    correct = [0, 0]
    non_matching_guess = []
    non_matching_code = []
    guess.length.times do |n|
      if guess[n] == @code[n]
        correct[0] += 1
      else
        non_matching_guess.push guess[n]
        non_matching_code.push @code[n]
      end
    end

    non_matching_guess.each do |num|
      non_matching_code.each_with_index do |n, index|
        if n == num
          correct[1] += 1
          non_matching_code[index] = "none"
          break
        end
      end
    end
    correct
  end

  def get_input
    guess = []
    4.times do |n|
      input = 0

      until @@COLORS.include? input
        puts "Guess color number #{n + 1}"
        input = gets.chomp.upcase
      end

      guess.push(input)
    end
    guess
  end

  def play
    guess_count = 1
    matches = 0
    until matches == 4 or guess_count > @@MAX_GUESSES
      puts "Turn #{guess_count}"
      input = get_input
      results = check_guess(input)
      matches = results[0]
      puts results
      guess_count += 1
    end
    if matches == 4
      puts "You win"
    else
      puts "You lose"
    end
  end
end

m = Mastermind.new(["RED", "BLUE", "GREEN", "YELLOW"])

m.play
