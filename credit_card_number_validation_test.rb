class CreditCardNumberValidationTest
  
  def initialize(credit_card_number)
    @card_number = credit_card_number
  end

  # To check the type of card
  def card_type
    length_of_card = @card_number.length()
    if length_of_card == 15 && @card_number =~ /^(34|37)/
      card_type = "AMEX:"
    elsif length_of_card == 16 && @card_number =~ /^6011/
      card_type = "Discover:"
    elsif length_of_card == 16 && @card_number =~ /^5[1-5]/
      card_type = "MasterCard:"
    elsif (length_of_card == 13 || length_of_card == 16) && @card_number =~ /^4/
      card_type = "VISA:"
    else
      card_type = "Unknown:"
    end
    card_type
  end
  
   # To check whether card is valid or not
   def is_valid?
     card_digits = ''
     @card_number.split('').reverse.each_with_index do |digit, index|
       card_digits += (digit.to_i*2).to_s if index % 2 == 1
       card_digits += digit if index % 2 == 0
     end
     card_digits.split('').inject(0) { |sum, element| sum + element.to_i} % 10 == 0 
   end

end  

if __FILE__ == $0
  puts "Please Enter The List Of Credit Card Numbers (one set of numbers per line) and add string END at the last."
  $/ = "END"
  user_input = STDIN.gets.split("\n") 
  puts "TYPE:      NUMBERS             (VALIDITY)"
  card_numbers_array = user_input.delete_if {|item| item.to_i == 0 || item == "" }
  card_numbers_array.each do |card_number|
    card = CreditCardNumberValidationTest.new(card_number)
    validity_message = card.is_valid? ? "(valid)" : "(invalid)"
    puts "#{card.card_type}   #{card_number}    #{validity_message}"
  end
end