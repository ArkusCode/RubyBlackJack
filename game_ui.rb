module GameUI
  NAME = /^[а-я\w]+$/i
  attr_reader :round_num

  def play_game
    initiate_game
    @round_num = 0
    run_game
  end

  protected

  def initiate_game
    system 'clear'
    line
    p '|           Weclome to Arkus BlackJack!             |'
    p '|             Standard American rules.              |'
    p '|        Starting cash = 100$  Blind = 10$          |'
    line
    create_player
    @dealer = Dealer.new
    @players.push(@player, @dealer)
  end

  def create_player
    p 'Player name: '
    p_name = gets.chomp
    raise 'Input can not be empty! Try again' if p_name !~ NAME
    @player = Player.new(p_name)
  rescue RuntimeError => e
    p e.message
    retry
  end

  def run_game
    system 'clear'
    @round_num += 1
    line
    p "Round #{@round_num} start"
    p "Cash - #{@player.money}$"
    line
    run_round
    next_round
  end

  def player_turn
    current_info
    blackjack?
    p 'Hit or Stand?(h/s)'
    choice = ''
    loop do
      choice = gets.chomp.downcase.capitalize!
      break if choice == 'H' || choice == 'S'
      p 'Wrong command, try again! (h/s)'
    end
    if choice == 'H'
      hit(@player)
      current_info
      raise 'Bust!' if player.current_total > 21
    else
      p "Player #{@player.id} Stand"
    end
  end

  def current_info
    p "Current hand: #{@player.hand.join(', ')}"
    p "Cards' value: #{@player.current_total}"
  end

  def dealer_info
    p "Dealer hand: #{@dealer.hand.join(', ')}"
    p "Dealer cards' value: #{@dealer.current_total}"
    sleep(1)
  end

  def next_round
    p 'Ready for another round? Y/N'
    choice = ''
    loop do
      choice = gets.chomp.downcase.capitalize!
      break if choice == 'Y' || choice == 'N'
      p 'Wrong command, try again! (Y\N)'
    end
    if choice == 'Y'
      cleanup
      qualify_players
      qualify_deck
      run_game
    else
      money = 100 - @player.money
      p 'Thanks for playing!'
      p "Your balance after the game: #{money * -1} bucks"
      exit
    end
  end

  def cleanup
    @players.each(&:reset)
  end

  def qualify_deck
    if @game_deck.size < 6
      p 'Loading new deck in shoe!'
      new_deck
    else
      p 'Shuffling the deck!'
      @game_deck.shuffle
    end
    sleep(1)
  end

  def qualify_players
    if @player.money.zero?
      p "You spend all yours' money. So sad."
      sleep(1)
      exit
    elsif @dealer.money.zero?
      p "Dealer run out of money! You'r cheater!"
      sleep(1)
      exit
    else
      true
    end
  end

  def line
    p '-----------------------------------------------------'
  end

  def blackjack_ui
    line
    p 'BlackJack! You win this round!'
    line
    next_round
  end

  def win_ui
    line
    p 'You win this round! '
    line
  end

  def lose_ui
    line
    p 'Bust! Your bet goes to dealer, good luck next round.'
    line
  end

  def draw_ui
    line
    p 'Draw. Bets returned to the owners.'
    line
  end
end
