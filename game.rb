class Game
  attr_accessor :game_deck, :player, :dealer, :players
  DECK = %w(2♥ 3♥ 4♥ 5♥ 6♥ 7♥ 8♥ 9♥ 10♥ J♥ Q♥ K♥ A♥
            2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ 10♣ J♣ Q♣ K♣ A♣
            2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ 10♠ J♠ Q♠ K♠ A♠
            2♦ 3♦ 4♦ 5♦ 6♦ 7♦ 8♦ 9♦ 10♦ J♦ Q♦ K♦ A♦).freeze
  def initialize
    @game_deck = DECK.shuffle
    @players = []
  end

  def initialize_game
    @player = Player.new("Vasyan")
    @dealer = Dealer.new
    @players.push(@player, @dealer)
  end

  def run_round
    2.times { @players.each { |player| hit(player) } }
    player_turn
    dealer_turn
  rescue RuntimeError => e
    p "Перебор! Ваша ставка уходит дилеру, удачи в следующем раунде."
    dealer_win
    next_round
  end

  def hit(player)
    player.hand.push(@game_deck.pop)
  end

  def dealer_turn
    @dealer.current_total
    @dealer.cur_total <= 16 ? hit(@dealer) : true
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

  def player_win
    @dealer.bust
    @player.win
  end

  def dealer_win
    @dealer.win
    @player.bust
  end

  def draw
    true
  end
end
