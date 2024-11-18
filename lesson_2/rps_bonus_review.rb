# rps_bonus.rb
# A rock paper scissors lizard spock game

require 'yaml'
MESSAGES = YAML.load_file('rps_bonus_collections.yml')
player_score = 0
cpu_score = 0

def messages(message)
  MESSAGES[message]
end

def yaml_lookup(key)
  messages(key)
end

def prompt
  messages(key)
end

def get_player_roll?
  gets.chomp
end

def someone_wins?(player_score, cpu_score)
  player_score == 3 || cpu_score == 3
end

puts yaml_lookup('welcome')
until someone_wins?(player_score, cpu_score) # main loop
  cpu_roll = %w(r p s l S).sample
  player_roll = ''

  loop do
    puts yaml_lookup('get_player_roll')
    player_roll = get_player_roll?
    if %w(r p s l S).include?(player_roll)
      break
    else
      puts "Invalid entry, try again."
    end
  end

  if player_roll == cpu_roll
    puts "both parties rolled #{MESSAGES[player_roll].first}, it's a tie!"
    puts "score remains: Player #{player_score}, CPU #{cpu_score}"
  elsif yaml_lookup(player_roll).include?(cpu_roll)
    puts "Player's '#{MESSAGES[player_roll].first}' " \
         "wins against CPU's '#{MESSAGES[cpu_roll].first}'"
    player_score += 1
    puts "scorecard reads: Player #{player_score}, CPU #{cpu_score}"
  else
    puts "CPU's '#{MESSAGES[cpu_roll].first}' " \
         "wins against Player's '#{MESSAGES[player_roll].first}'"
    cpu_score += 1
    puts "scorecard reads: Player #{player_score}, CPU #{cpu_score}"
  end
  puts "Player is declared the Grand Champion!" if player_score == 3
  puts "CPU is declared the Grand Champion!" if cpu_score == 3
end
