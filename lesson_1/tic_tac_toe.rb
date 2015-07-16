require "pry"

board = (1..9).map { " " }

def all_spaces_filled?(board)
  filled_spaces = board.select {|space| space != " "}
  filled_spaces.length == board.length
end

def free_space?(space, board)
  board[space] == " "
end

def computer_move(board)
  board.map.with_index {|space, i| space == " " ? i : nil }.reject {|n| n == nil }.sample
end

def computer_turn(board)
  return if all_spaces_filled?(board)
  move = computer_move(board)
  board[move] = "O"
end

def print_board(board)
  system "clear"
  vert_lines = "     |     |"
  horiz_line = "-----+-----+-----"
  puts vert_lines
  puts "  #{board[0]}  |  #{board[1]}  |  #{board[2]}"
  puts vert_lines
  puts horiz_line
  puts vert_lines
  puts "  #{board[3]}  |  #{board[4]}  |  #{board[5]}"
  puts vert_lines
  puts horiz_line
  puts vert_lines
  puts "  #{board[6]}  |  #{board[7]}  |  #{board[8]}"
  puts vert_lines
end

def check_winner(board)
  winning_lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  winning_lines.each do |line|
    return "Player" if board.values_at(*line).count('X') == 3
    return "Computer" if board.values_at(*line).count('O') == 3
  end
  nil
end

begin
  print_board(board)
  begin
    puts "Choose a space from 1 through 9"
    space = gets.chomp.to_i - 1
    unless free_space?(space, board)
      space = nil
      puts "Sorry, that space is already taken"
    end
  end until space
  board[space] = "X"
  winner = check_winner(board)
  computer_turn(board) unless winner
  print_board(board)
  winner = check_winner(board)
  puts "#{winner} is the winner!" if winner
end until all_spaces_filled?(board) || winner
