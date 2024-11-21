# rps_bonus_review_with_changes.rb
# A rock paper scissors lizard spock game

def prompt(message)
  Kernel.puts("=> #{message}")
end

greetings = "Welcome to a new game of Rock, Paper, Scissors, Lizard, Spock!"

choose_player_move = <<-MSG
Please choose from the following:
  Note: your entry is case-sensitive...
  'r' for rock
  'p' for paper
  's' for scissors
  'l' for lizard
  'S' for Spock
  MSG
player_is_the_champ = "Player is declared the Grand Champion!"
cpu_is_the_champ = "CPU is declared the Grand Champion!"

PAIRS = {
  'r' => 'rock',
  'p' => 'paper',
  's' => 'scissors',
  'l' => 'scissors',
  'S' => 'Spock'
}

GAME_MOVES_ARRAY = %w(r p s l S)

WINNING_MATCHUPS = {
  'r' => ['s', 'l'],
  'p' => ['r', 's'],
  's' => ['p', 'l'],
  'l' => ['p', 'l'],
  'S' => ['r', 's']
}

GAMES_MET_TO_WIN = 3

def player_wins_enough?(player_score)
  player_score == GAMES_MET_TO_WIN
end

def cpu_wins_enough?(cpu_score)
  cpu_score == GAMES_MET_TO_WIN
end

def get_player_roll?
  gets.chomp
end

def tie?(player_roll, cpu_roll)
  player_roll == cpu_roll
end

def someone_wins?(player_score, cpu_score)
  player_wins_enough?(player_score) || cpu_wins_enough?(cpu_score)
end

prompt(greetings)
player_score = 0
cpu_score = 0
until someone_wins?(player_score, cpu_score) # main loop
  cpu_roll = GAME_MOVES_ARRAY.sample
  player_roll = ''

  loop do
    prompt(choose_player_move)
    player_roll = get_player_roll?
    if GAME_MOVES_ARRAY.include?(player_roll)
      break
    else
      puts prompt("Invalid entry, try again.")
    end
  end

  if tie?(player_roll, cpu_roll)
    puts "both parties rolled #{PAIRS[player_roll]}, it's a tie!"
    puts "score remains: Player #{player_score}, CPU #{cpu_score}"
  elsif WINNING_MATCHUPS[player_roll].include?(cpu_roll)
    puts "Player's '#{PAIRS[player_roll]}' " \
         "wins against CPU's '#{PAIRS[cpu_roll]}'"
    player_score += 1
    puts "scorecard reads: Player #{player_score}, CPU #{cpu_score}"
  else
    puts "CPU's '#{PAIRS[cpu_roll]}' " \
         "wins against Player's '#{PAIRS[player_roll]}'"
    cpu_score += 1
    puts "scorecard reads: Player #{player_score}, CPU #{cpu_score}"
  end
  puts prompt(player_is_the_champ) if player_wins_enough?(player_score)
  puts prompt(cpu_is_the_champ) if cpu_wins_enough?(cpu_score)
end
