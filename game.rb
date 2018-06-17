class Game
  include GameUI

  attr_accessor :game_deck, :player, :dealer, :players
  DECK = %w[2♥ 3♥ 4♥ 5♥ 6♥ 7♥ 8♥ 9♥ 10♥ J♥ Q♥ K♥ A♥
            2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ 10♣ J♣ Q♣ K♣ A♣
            2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ 10♠ J♠ Q♠ K♠ A♠
            2♦ 3♦ 4♦ 5♦ 6♦ 7♦ 8♦ 9♦ 10♦ J♦ Q♦ K♦ A♦].freeze
  def initialize
    new_deck
    @players = []
  end

  protected

  def new_deck
    @game_deck = DECK.shuffle
  end

  def run_round
    2.times { @players.each { |player| hit(player) } }
    player_turn
    dealer_turn
  rescue RuntimeError
    dealer_win
    next_round
  end

  def hit(player)
    if @game_deck.last !~ /[A]/
      player.hand.unshift(@game_deck.pop)
    else
      player.hand.push(@game_deck.pop)
    end
  end

  def blackjack?
    @player.current_total == 21 ? blackjack! : false
  end

  def dealer_turn
    @dealer.current_total
    @dealer.cur_total <= 16 ? hit(@dealer) : true
    dealer_info
    round_result
  end

  def round_result
    if @dealer.current_total > 21
      player_win
    elsif @dealer.current_total > @player.current_total
      dealer_win
    elsif @dealer.current_total == @player.current_total
      draw
    else
      player_win
    end
  end

  def blackjack!
    @dealer.bust
    @player.win
    blackjack_ui
  end

  def player_win
    @dealer.bust
    @player.win
    win_ui
  end

  def dealer_win
    @dealer.win
    @player.bust
    lose_ui
  end

  def draw
    draw_ui
  end
end
