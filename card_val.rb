class Card

 # init the class to accept card numbers
  def initialize card_num
    @num = card_num
  end

 # sanity check 1: card type (the easy bit)
 # matching card number length and the first digits of the entered number to determine card type
 # could use '@num.match' or '@num =~'
 # consulted http://www.rubular.com/ to sanity check my Regexp
  def card_type
    length = @num.length
    if length == 15 && @num =~ /^(34|37)/
    	return 'AMEX'
    elsif length == 16 && @num =~ /^6011/
    	return 'Discover'
    elsif length == 16 && @num =~ /^5[1-5]/
    	return 'MasterCard'
    elsif (length == 13 || length == 16) && @num =~ /^4/
    	return 'Visa'
    else
      return 'Unknown'
    end
  end

 # sanity check 2: luhn algorithm test
  def num_valid?
    number = ''
    # (1)need to split the number down first to handle it digit by digit
    # (2)because number length can change, better to reverse it and go front to back
    # (3)put through an each block to loop through the digits, adding with_index to help the modulo (consulted )
    # (4)using a modulo to apply *2 if remainder is not 0 (i.e. every other number starting at position 1, using the index)
    # (5)building up the number string with << (could use += but no need to create a new object every time)
    @num.split('').reverse.each_with_index do |digit, index|
      number << digit if index%2 == 0
      number << (digit.to_i*2).to_s if index%2 != 0
    end

 # lastly have to check the result added together modulo's to zero
 # consulted http://blog.jayfields.com/2008/03/ruby-inject.html for inject syntax refresher
    # (1)need to split the number down into an array so inject() can turn them to_i and give us the sum
    # (2)using a modulo to ensure the final sum is a multiple of 10
    number.split('').inject { |r,e| r.to_i + e.to_i } % 10 == 0
  end
end

 # methods finished, so now need to run program within current file
 # could run a unit test, but best practice would be to do so in seperate file with a require 'card_val', and 1 file is enough
 # consulted http://www.ruby-forum.com/topic/58437 for run in same file sanity check
   # (1)get command line input, join together to remove spaces and create an instance of Card class
   # (2)print out card type based on card_type method
   # (3)run flow control on num_val for valid/invalid response
  if __FILE__ == $0
    
    card_test = Card.new(ARGV.join.chomp)
    
    if card_test.num_valid?
    	puts "#{card_test.card_type}: #{ARGV.join.chomp} (valid)"
    else
    	puts "#{card_test.card_type}: #{ARGV.join.chomp} (invalid)"
    end
  end