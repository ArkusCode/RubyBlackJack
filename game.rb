class Game
  attr_reader :game_deck, :bank, :player, :dealer, :players, :ui

  def initialize
    @game_deck = Deck.new
    @dealer = Dealer.new
    @bank = Bank.new
    @ui = GameUi.new
    @players = []
  end

  def play_game
    @ui.initiate_game
    @player = Player.new(@ui.create_player)
    @players.push(@player, @dealer)
    run_round
  end

  protected

  def run_round
    @ui.round_start
    2.times { @players.each { |player| @game_deck.hit(player) } }
    player_turn
    dealer_turn
    next_round?
  rescue RuntimeError
    dealer_win
    next_round?
  end

  def player_turn
    @ui.current_info(@player)
    blackjack?
    choice = @ui.player_choice
    if choice == :hit
      @game_deck.hit(@player)
      @ui.current_info(@player)
      raise 'Bust!' if @player.current_total > 21
    else
      @ui.player_stand(@player)
    end
  end

  def next_round?
    choice = @ui.next_round
    if choice == :yes
      cleanup
      qualify_players
      qualify_deck
      run_round
    else
      money = 100 - @player.money
      @ui.the_end(money)
      exit
    end
  end

  def dealer_turn
    @dealer.current_total < 17 ? @game_deck.hit(@dealer) : true
    @ui.dealer_info(@dealer)
    round_result
  end

  def blackjack?
    if @player.current_total == 21
      blackjack!
      next_round?
    else
      false
    end
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

  def cleanup
    @players.each(&:reset)
  end

  def qualify_deck
    if not_enough_cards?
      @ui.new_deck_message
      deck_renew
    else
      @ui.shuffling_message
      @game_deck.deck.shuffle
    end
    sleep(1)
  end

  def qualify_players
    if @player.money.zero?
      @ui.not_enough_money
      sleep(1)
      exit
    elsif @dealer.money.zero?
      @ui.casino_lose
      sleep(1)
      exit
    else
      true
    end
  end

  def not_enough_cards?
    @game_deck.deck.size < 6
  end

  def deck_renew
    @game_deck.new_deck
  end

  def blackjack!
    @ui.blackjack_message
    @bank.bust(@dealer)
    @bank.win(@player)
  end

  def player_win
    @ui.player_win_message
    @bank.bust(@dealer)
    @bank.win(@player)
  end

  def dealer_win
    @ui.player_lose_message
    @bank.bust(@player)
    @bank.win(@dealer)
  end

  def draw
    @ui.draw_message
  end
end
