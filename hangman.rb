
class Hangman
  attr_reader :word, :display_letters
  def initialize
    @word = generate_word
    @display_letters = Array.new(@word.length, "_")
    @vowels = "a e i o u y"
    @consonants = "b c d f g h j k l m n p q r s t v w x z"
    @guesses = 7
    @word_teaser = ""
    @correct_letters = ""
  end

  def generate_word
    dictionary = File.readlines("dictionary.txt")
    word = dictionary.sample[0...-2].downcase 
     while word.length < 5 || word.length > 12
      word = dictionary.sample[0...-2].downcase
      
    end
    return word.downcase
  end

  def print_teaser
    
    @word.length.times do 
      @word_teaser += "_ "
    end
    return @word_teaser
  end

  def letters_display
    puts "            #{@vowels}              "
    puts "---------------------------------------"
    puts "   #{@consonants}"
  end

  def update_letters_display(letter)
    if @vowels.include?(letter)
      @vowels.gsub!(letter, "")
    end
    if @consonants.include?(letter)
      @consonants.gsub!(letter, "")
    end
  end

  def update_teaser(letter)
    word = @word_teaser.split(" ")
    
    @word.each_char.with_index do |char, index|
      
      if @word[index].include?(letter)
        #word.delete_at(index)
        word[index] = letter
        @correct_letters += letter
        
      end
    end
      @word_teaser = word.join(" ")
     
  end
  def guess_letter
    if @guesses > 0
            
      puts
      puts "Pick a letter from the letter bank. Or type 'save' to save game."
      #bad_chars = "`1234567890-=\][';/.,!@#$%^&*()_+"
      
      #while guessing
      letter = gets.chomp.downcase
      #redo if bad_chars.include?(letter)
      #guessing = false
      if @word.include?(letter)
        puts
        puts "Nice guess!"
        update_teaser(letter)
        update_letters_display(letter)
        p @word_teaser
        
        
      else
        @guesses -= 1 unless letter == "save"
        puts
        puts "Try another letter. You have #{@guesses} remaining."
        update_letters_display(letter)
        letters_display
        guess_letter
      end
    else return "Game over."
    end
  end

  def game 
    puts "Welcome to Hangman my person. Your word is #{@word.length.to_s} letters long.\nYou have 7 lives to guess the word. For every incorrect guess, you lose a life. Good luck."
    puts "Here's a little preview of your word.  =>  #{print_teaser}"
    puts @word
    puts @word_teaser
    while guess_letter != "Game over."  
      if @correct_letters.length == @word.length
        puts "Congratulations player. You guessed the word."
      end
      guess_letter
    end
    puts "Better luck next time player."
  end
  
end

prine = Hangman.new
puts prine.game


