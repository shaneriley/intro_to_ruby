def say(msg)
  puts "#{msg}"
end

def get_values
  say "What is the first number?"
  num1 = gets.chomp.to_i

  say "What is the second number?"
  num2 = gets.chomp.to_i

  [num1, num2]
end

def get_operator
  say "1) Add\n2) Subtract\n3) Multiply\n4) Divide"
  gets.chomp
end

def say_result(solution)
  say "Answer: #{solution}"
end

def calculate(num1, num2, operator)
  case operator
  when "1"
    result = num1.to_i + num2.to_i
  when "2"
    result = num1.to_i - num2.to_i
  when "3"
    result = num1.to_i * num2.to_i
  when "4"
    result = num1.to_f / num2.to_f
  else
    say "Please enter a number from 1 through 4"
    get_operator(num1, num2)
    return
  end

  say_result result
end

def process_request(num1, num2)
  operator = get_operator
  result = calculate(num1, num2, operator)
end

def start
  num1, num2 = get_values
  process_request(num1, num2)

  prompt_for_new_calculation
end

def prompt_for_new_calculation
  say "Would you like to process another calculation?"

  start if gets.chomp.downcase == "y"
end

start
