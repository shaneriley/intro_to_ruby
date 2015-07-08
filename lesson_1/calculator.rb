def say(msg)
  puts "#{msg}"
end

def get_values
  say "What is the first number?"
  num1 = gets.chomp.to_i

  say "What is the second number?"
  num2 = gets.chomp.to_i

  return num1, num2
end

def get_operator
  say "1) Add\n2) Subtract\n3) Multiply\n4) Divide"
  gets.chomp
end

def say_result(solution)
  say "Answer: #{solution}"
end

def calculate(num1, num2)
  operator = get_operator.to_i

  if operator == 1
    result = num1 + num2
  elsif operator == 2
    result = num1 - num2
  elsif operator == 3
    result = num1 * num2
  elsif operator == 4
    result = num1 / num2
  end

  if result.nil?
    say "Please enter a number from 1 through 4"
    calculate
  else
    say_result result
  end

  prompt_for_new_calculation
end

def start
  num1, num2 = get_values
  calculate(num1, num2)
end

def prompt_for_new_calculation
  say "Would you like to process another calculation?"

  case gets.chomp.downcase
  when "y"
    start
  else
    nil
  end
end

start
