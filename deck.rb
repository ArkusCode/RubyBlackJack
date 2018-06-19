class Deck
  attr_reader :deck
  DECK = %w[2♥ 3♥ 4♥ 5♥ 6♥ 7♥ 8♥ 9♥ 10♥ J♥ Q♥ K♥ A♥
            2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ 10♣ J♣ Q♣ K♣ A♣
            2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ 10♠ J♠ Q♠ K♠ A♠
            2♦ 3♦ 4♦ 5♦ 6♦ 7♦ 8♦ 9♦ 10♦ J♦ Q♦ K♦ A♦].freeze

  def initialize
    new_deck
  end

  def new_deck
    @deck = DECK.shuffle
  end

  def hit(player)
    if @deck.last !~ /[A]/
      player.hand.unshift(@deck.pop)
    else
      player.hand.push(@deck.pop)
    end
  end
end
