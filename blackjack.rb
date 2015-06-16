require "pry"

def calculate_total(hand)
  card_values = hand.collect { |val| val[1] }

  total = 0
  card_values.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  card_values.select { |val| val == "Ace"}.count.times do
    total -= 10 if total > 21
  end

  total
end

def format_hand(hand, total)
  hand.map do |value|
    print "#{value[1]} of #{value[0]} "
  end
  puts "\nCurrent Total: #{total}"
end

puts "Welcome to Black Jack!"

# Deck
suits = ["Clubs", "Diamonds", "Spades", "Hearts"]

values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

deck = suits.product(values)

deck.shuffle!

player_hand = []
dealer_hand = []

# initial deal
2.times do
player_hand << deck.pop
dealer_hand << deck.pop
end

player_total = calculate_total(player_hand)
dealer_total = calculate_total(dealer_hand)

display_player = format_hand(player_hand, player_total)

loop do
  puts "Would you like to stay or hit?"
  player_response = gets.chomp
  break if player_response == "stay"
  if player_response == "hit"
    player_hand << deck.pop
    player_total = calculate_total(player_hand)
    if player_total > 21
      puts "You bust"
      break
    end
    puts format_hand(player_hand, player_total)
  elsif player_response != "hit" || player_response != "stay"
    puts "please enter hit or stay"
  end
end

loop do
  break if dealer_total >= 21
  if dealer_total < 17
    dealer_hand << deck.pop
    dealer_total = calculate_total(dealer_hand)
  end
end

puts "---------------------------------------------------------"

case
when dealer_total == 21 && player_total == 21
  puts "It's tie"
  puts "Dealer's Hand"
  display_dealer = format_hand(dealer_hand, dealer_total)
  puts "Player's Hand"
  display_player = format_hand(player_hand, player_total)
when dealer_total <= 21 && player_total > 21
  puts "Player busts Dealer Wins"
  puts "Dealer's Hand"
  display_dealer = format_hand(dealer_hand, dealer_total)
  puts "Player's Hand"
  display_player = format_hand(player_hand, player_total)
when player_total <= 21 && dealer_total > 21
  puts "Dealer busts Player Wins"
  puts "Dealer's Hand"
  display_dealer = format_hand(dealer_hand, dealer_total)
  puts "Player's Hand"
  display_player = format_hand(player_hand, player_total)
when player_total > dealer_total && player_total <= 21
  puts "Player Wins!"
  puts "Dealer's Hand"
  display_dealer = format_hand(dealer_hand, dealer_total)
  puts "Player's Hand"
  display_player = format_hand(player_hand, player_total)
when dealer_total > player_total && dealer_total <= 21
  puts "Dealer Wins!"
  puts "Dealer's Hand"
  display_dealer = format_hand(dealer_hand, dealer_total)
  puts "Player's Hand"
  display_player = format_hand(player_hand, player_total)
end
