class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(new_word)
  	@word = new_word
  	@guesses = ""
  	@wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    if letter == ''
      raise ArgumentError, "empty guess"
    elsif (letter =~ /[A-Za-z]/) == nil
      raise ArgumentError, "not a string"
    elsif letter == nil
      raise ArgumentError, "nil"
    end

    if @word.include?(letter)
      if @guesses.include?(letter) == false
        @guesses += letter
      else
      	return false
      end
    elsif @word.include?(letter) == false
      if @wrong_guesses.include?(letter) == false
        @wrong_guesses += letter
      else
      	return false
      end
  	end
  end

  def word_with_guesses()
    the_word = ""
    @word.split("").each do |c|
      if @guesses.include?(c)
      	the_word += c
      else
      	the_word += '-'
      end
    end
    return the_word
  end

  def check_win_or_lose()
  	if word_with_guesses() == @word
  	  return :win
  	elsif @wrong_guesses.length >= 7
  	  return :lose
  	else
  	  return :play
  	end
  end

end
