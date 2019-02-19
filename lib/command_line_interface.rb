def welcome
  # puts out a welcome message here!
  puts "please enter a character"
end

def get_character_from_user
  # use gets to capture the user's input. This method should return that input, downcased.
  user_input = gets.chomp
  user_input = user_input.downcase
  user_input
end
