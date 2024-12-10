# rps_bonus_review_yml_facing_text.rb
# A rock paper scissors lizard spock game

require 'yaml'

# CONSTANTS
MESSAGES = YAML.load_file('rps_bonus_review_yml_user_facing_text.yml')
MOVE_FULL_NAMES = {
  'r' => 'rock',
  'p' => 'paper',
  's' => 'scissors',
  'l' => 'scissors',
  'S' => 'Spock'
}
VALID_MOVES = %w(r p s l S)
WINNING_MATCHUPS = {
  'r' => ['s', 'l'],
  'p' => ['r', 's'],
  's' => ['p', 'l'],
  'l' => ['p', 'l'],
  'S' => ['r', 's']
}
GAMES_MET_TO_WIN = 3

# initialize scores
player_score = 0
cpu_score = 0

# Helper Functions
def message(msg)
  MESSAGES[msg]
end

def prompt(msg)
  message = message(msg)
  Kernel.puts("=> #{message}")
end

def get_player_roll?
  gets.chomp
end

def player_wins_enough?(player_score)
  player_score == GAMES_MET_TO_WIN
end

def player_not_yet_winner?(player_score)
  player_score < GAMES_MET_TO_WIN
end

def cpu_not_yet_winner?(cpu_score)
  cpu_score < GAMES_MET_TO_WIN
end

def cpu_wins_enough?(cpu_score)
  cpu_score == GAMES_MET_TO_WIN
end

def valid_player_roll?(player_roll)
  VALID_MOVES.include?(player_roll)
end

def player_wins_round?(player_roll, cpu_roll)
  WINNING_MATCHUPS[player_roll].include?(cpu_roll)
end

def get_player_choice?
  loop do
    prompt('choose_player_roll')
    player_roll = get_player_roll?
    if valid_player_roll?(player_roll)
      return player_roll
    else
      puts prompt("try_again")
    end
  end
end

def tie?(player_roll, cpu_roll)
  player_roll == cpu_roll
end

def tie_result?(player_roll)
  puts "both parties rolled #{MOVE_FULL_NAMES[player_roll]}, it's a tie!"
end

def tie_scoreboard?(player_score, cpu_score)
  puts "score remains: Player #{player_score}, CPU #{cpu_score}"
end

def someone_wins?(player_score, cpu_score)
  player_wins_enough?(player_score) || cpu_wins_enough?(cpu_score)
end

def round_won_scoreboard?(player_score, cpu_score)
  puts "scorecard reads: Player #{player_score}, CPU #{cpu_score}"
end

def player_won_round_result?(player_roll, cpu_roll)
  puts "Player's '#{MOVE_FULL_NAMES[player_roll]}' " \
       "wins against CPU's '#{MOVE_FULL_NAMES[cpu_roll]}'"
end

def cpu_won_round_result?(player_roll, cpu_roll)
  puts "CPU's '#{MOVE_FULL_NAMES[cpu_roll]}' " \
       "wins against Player's '#{MOVE_FULL_NAMES[player_roll]}'"
end

def did_player_win?(player_score)
  puts prompt('player_is_the_champ') if player_wins_enough?(player_score)
end

def did_cpu_win?(cpu_score)
  puts prompt('cpu_is_the_champ') if cpu_wins_enough?(cpu_score)
end

def clear_screen?
  prompt('to_continue')
  gets
  system "clear" # screen clear command may differ by runtime environment
end

prompt('greetings')
until someone_wins?(player_score, cpu_score) # main loop
  cpu_roll = VALID_MOVES.sample
  player_roll = get_player_choice?

  if tie?(player_roll, cpu_roll)
    tie_result?(player_roll)
    tie_scoreboard?(player_score, cpu_score)
  elsif player_wins_round?(player_roll, cpu_roll)
    player_won_round_result?(player_roll, cpu_roll)
    player_score += 1
    round_won_scoreboard?(player_score, cpu_score)
  else
    cpu_won_round_result?(player_roll, cpu_roll)
    cpu_score += 1
    round_won_scoreboard?(player_score, cpu_score)
  end
  clear_screen?
  did_player_win?(player_score)
  did_cpu_win?(cpu_score)
end
