class BlackJack
  attr_accessor :game
  def initialize
    greeting
    @game = TwentyOneGame.new(prompt_for_players)
    display(game.table_to_s)
    run
  end

  def run
    loop do
      print "player #{game.active_player} command: "
      command = gets.chomp
      break if command == "exit"
      execute_command(command)
      break if game.resolved
    end
  end

  def execute_command(command)
    case command
    when "help"
      display_help
    when "hit"
      display(game.hit)
    when "stay"
      display(game.stay)
    when "new"
      new_game
    end
  end

  def new_game
    game = TwentyOneGame.new
    display(game.table_to_s)
  end

  def display_help
    puts "command options: 'help', 'hit', 'stay', 'exit', 'new'"
  end

  def greeting
    puts "Welcome to the 21 game"
    display_help
  end

  def display(output)
    puts output
  end

  def prompt_for_players
    print "How many players will there be: "
    gets.chomp.to_i
  end
end

class TwentyOneGame
  attr_accessor :deck, :dealer, :players, :active_player, :resolved
  def initialize(player_count)
    @deck           = Deck.new
    @dealer         = deal_out(Player.new)
    @players        = []
    @active_player  = 0
    @resolved       = false
    set_players(player_count)
  end

  def set_players(player_count)
      # gets current length of players array (effectivly the next open index)
      # makes a new player object w/ this as an id
      # deals the new player cards
      # adds this new player to the players array
    player_count.times do
      players << deal_out(Player.new(players.length))
    end
  end

  def deal_out(player)
    player.hand = [deck.deal_one, deck.deal_one]
    player
  end

  def hit
    player = players[active_player]
    player.add_card(deck.deal_one)
    turn_to_s(player)
  end

  def stay
    player = players[active_player]
    increment_active_player
    turn_to_s(player)
  end

  def increment_active_player
    if everyone_played?
      resolve_game 
    else
      self.active_player += 1
    end
  end

  def everyone_played?
    active_player+1 == players.length
  end

  def resolve_game
    dler = Deck.score_hand(dealer.hand)
    dealer.flip_cards
    players.each do |player|
      hand = Deck.score_hand(player.hand)
      if hand > 21
        player.hand << "Bust"
      elsif hand <= dler
        player.hand << "Lose"
      else
        player.hand << "Win"
      end
    end
    resolved = true
  end

  def table_to_s
    table = "Dealer: #{dealer.showing}"
    players.each do |player|
      table += ", player#{player.id+1}:#{player.hand_to_s}"
    end
    table
  end

  def turn_to_s(player)
    "Dealer:#{dealer.showing}, Player #{player.id+1}: #{player.hand_to_s}"
  end
end


class Deck
  attr_accessor :cards
  def initialize
    @cards = set_cards
  end

  def set_cards
    ary = []
    4.times {ary << "A"}
    4.times {ary << "2"}
    4.times {ary << "3"}
    4.times {ary << "4"}
    4.times {ary << "5"}
    4.times {ary << "6"}
    4.times {ary << "7"}
    4.times {ary << "8"}
    4.times {ary << "9"}
    4.times {ary << "10"}
    4.times {ary << "J"}
    4.times {ary << "Q"}
    4.times {ary << "K"}
    ary.shuffle
  end

  # def done?
  #   cards.empty?
  # end

  def deal_one
    cards.pop
  end

  ### class methods ###

  def self.score_hand(hand)
    total = 0
    ace = 0

    hand.each do |card|
      if card == "A"
        total += 11
        ace += 1
      elsif card.to_i != 0
        total += card.to_i
      else
        total += 10
      end
    end

    while ace > 0 && total > 21
      ace   -= 1
      total -= 10
    end

    total
  end
end


class Player
  attr_accessor :id
  def initialize(id = nil)
    @id   = id
    @hand
  end

  def hand=(hand)
    @hand = hand
  end

  def add_card(card)
    @hand << card
  end

  def hand
    @hand
  end

  def showing
    hand[0]
  end

  def flip_cards
    hnd = hand.join(" ")
    hand = [hnd]
  end

  def hand_to_s
    hand.join(" ")
  end
end

# BlackJack.new