class String
  def colorize(move)
    color = { "p" => 31, "r" => 32, "s" => 36 }[move]
    "\e[#{color}m#{self}\e[0m"
  end
end

MOVES = {
  "p" => "paper",
  "r" => "rock",
  "s" => "scissors"
}

@wins = 0
@losses = 0
@games = 0

def top_border
  puts "╔#{"═" * 78}╗"
end

def border(line = "")
  puts "#{" " * 79}║\r║ #{line}"
end

def bottom_border
  puts "╚#{"═" * 78}╝"
end

def pad(lines = 8)
  puts "\n" * lines
end

def clear
  system "clear" or system "cls"
end

def intro_screen
  clear

  pad
  top_border
  border
  border "Choose #{"(P)aper".colorize("p")}, #{"(R)ock".colorize("r")}, or #{"(S)cissors".colorize("s")}\n"
  border
  bottom_border
  pad 1
end

def decision_screen(player_move, computer_move)
  decision = decide_game(player_move, computer_move)
  @wins += 1 if decision[:point] == 1
  @losses += 1 if decision[:point] == -1
  @games += 1

  clear
  pad
  top_border
  border
  border "You chose #{player_move.colorize(player_move)}. Computer chose #{computer_move.colorize(computer_move)}.\n"
  border
  border "#{MOVES[player_move].colorize(player_move)} #{decision[:msg]} #{MOVES[computer_move].colorize(computer_move)}"
  border "Play again?\n"
  border
  bottom_border
  pad 1
end

def decide_game(player_move, computer_move)
  tie = { msg: "ties with", point: 0 }
  win = { msg: "wins over", point: 1 }
  lose = { msg: "loses to", point: -1 }
  outcomes = {
    "p" => {
      "p" => tie,
      "r" => win,
      "s" => lose
    },
    "r" => {
      "p" => lose,
      "r" => tie,
      "s" => win
    },
    "s" => {
      "p" => win,
      "r" => lose,
      "s" => tie
    }
  }
  outcomes[player_move][computer_move]
end

loop do
  intro_screen

  player_move = gets.chomp.downcase
  computer_move = MOVES.keys.sample

  decision_screen(player_move, computer_move)

  answer = gets.chomp.downcase

  break if answer != "y"
end

ties = @games - @wins - @losses
ratio = (@wins.to_f / @games.to_f * 100).round(2)

clear
pad
top_border
border
border "Your stats"
border
border "┌#{"─" * 74}┐"

headings = "#{"Wins".colorize("s")} │ #{"Losses".colorize("s")} │ #{"Ties".colorize("s")} │ #{"Win Ratio".colorize("s")}"
stats = "#{@wins}#{" " * (4 - @wins.to_s.length)} │ #{@losses}#{" " * (6 - @losses.to_s.length)} │ #{ties}#{" " * (4 - ties.to_s.length)} │ #{ratio}%#{" " * (7 - ratio.to_s.length)}"

border "│ #{headings}#{" " * (72 - headings.length + 36)} │"
border "│ #{stats}#{" " * (72 - stats.length)} │"
border "└#{"─" * 74}┘"
border "Thanks for playing!"
border
bottom_border
pad 1
