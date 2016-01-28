class Deck
  attr_accessor :card_deck, :players

  def initialize
    @card_deck = set_card_deck
    @players   = set_players
  end

  def set_card_deck
    ary  = []
    ary += ["A"]*4
    ary += ["2"]*4
    ary += ["3"]*4
    ary += ["4"]*4
    ary += ["5"]*4
    ary += ["6"]*4
    ary += ["7"]*4
    ary += ["8"]*4
    ary += ["9"]*4
    ary += ["10"]*14
    ary += ["J"]*2
    ary.shuffle
  end

  def set_players
    myHash = Hash.new
    myHash[1] = [card_deck.pop( ), card_deck.pop( )]
    myHash[2] = [card_deck.pop( ), card_deck.pop( )]
    return myHash
  end

  def evaluate_my_hand(hand)
    handTotal = 0
    numberOfAces = 0
    hand.each do |card|
      if card == "J" then
        handTotal+= 10
      elsif card == "A" then
        numberOfAces += 1
        handTotal += 11
      else
        handTotal += card.to_i
      end
    end

    while handTotal > 21 && numberOfAces > 0 do
       handTotal -= 10
       numberOfAces -= 1
    end

    return false if handTotal > 21
    handTotal
  end

  def compare_hands
    dealer = players[players.size]
    players[players.size] = nil
    dealer = evaluate_my_hand(dealer)
    players.each do |player_number, player_hand|
      if evaluate_my_hand(player_hand) > dealer
        winner = player_number
      end
    end

    winner
  end
  
end

d = Deck.new
puts d.card_deck
puts d.compare_hands
# puts d.players
# puts d.evaluate_my_hand(d.players[1])
# puts d.evaluate_my_hand(d.players[2])

### d.example
### d.other_example
