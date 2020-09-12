class Mastermind
  @@COLORS = ["RED", "BLUE", "GREEN", "YELLOW", "BLACK", "WHITE"]
  @@MAX_GUESSES = 8

  #make a random code
  def generate_code
    a = []
    4.times do
      a.push(@@COLORS.sample)
    end
    a
  end

  def initialize
    @code = generate_code
  end

  private

  #checks if the guess was correct and tells you how close it was in terms of black and white pegs
  def check_guess(guess, code)
    correct = [0, 0]
    non_matching_guess = []
    non_matching_code = []
    guess.length.times do |n|
      if guess[n] == code[n]
        correct[0] += 1
      else
        non_matching_guess.push guess[n]
        non_matching_code.push code[n]
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

  #The user enters four colors, which is their guess for one turn it must be a color in @@COLORS
  def get_input
    guess = []
    4.times do |n|
      input = 0

      until @@COLORS.include? input
        puts "Enter color number #{n + 1}"
        input = gets.chomp.upcase
      end

      guess.push(input)
    end
    guess
  end

  #player guesses until they answer is found or turns exceeds maximum
  def player_play
    guess_count = 1
    matches = 0
    until matches == 4 or guess_count > @@MAX_GUESSES
      puts "Turn #{guess_count}"
      input = get_input
      results = check_guess(input, @code)
      matches = results[0]
      puts "You guessed: #{input}"
      puts "Black pins: #{results[0]} White pins: #{results[1]}"
      guess_count += 1
    end
    if matches == 4
      puts "You win"
    else
      puts "You lose"
    end
  end

  def comp_calc(guess)
  end

  def create_list
    l = @@COLORS.length
    list = []
    l.times do |a|
      l.times do |b|
        l.times do |c|
          l.times do |d|
            list.push [@@COLORS[a], @@COLORS[b], @@COLORS[c], @@COLORS[d]]
          end
        end
      end
    end
    list
  end

  def prune_list(list, guess, answer)
    new_list = []
    list.each do |item|
      if check_guess(guess, item) == answer
        new_list.push(item)
      end
    end
    new_list
  end

  #player guesses until they answer is found or turns exceeds maximum
  def comp_play
    master_list = create_list
    puts "Enter the code: "
    @code = get_input
    puts "Code: #{@code}"

    guess_count = 1
    matches = 0

    rand1 = rand(6)
    rand2 = rand(6)
    until rand2 != rand1
      rand2 = rand(6)
    end
    input = [@@COLORS[rand1], @@COLORS[rand1], @@COLORS[rand2], @@COLORS[rand2]]

    until matches == 4 or guess_count > @@MAX_GUESSES
      puts "Turn #{guess_count}"
      puts "Computer guesses #{input}"

      results = check_guess(input, @code)
      matches = results[0]

      puts "Black pins: #{results[0]}   White pins: #{results[1]}"
      guess_count += 1

      master_list = prune_list(master_list, input, results)

      input = master_list.sample
    end

    if matches == 4
      puts "You lose"
    else
      puts "You win"
    end
  end

  public

  #Determines if the player will guess the code or make the code
  def play
    puts "Do you want to be the codebreaker? [Y/N]"
    input = gets.chomp.upcase
    if input == "Y"
      player_play
    else
      comp_play
    end
  end
end

m = Mastermind.new

m.play
