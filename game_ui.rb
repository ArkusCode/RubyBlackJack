class GameUi
  NAME = /^[а-я\w]+$/i
  CHOICE = { 'H' => :hit, 'S' => :stand, 'Y' => :yes, 'N' => :no }.freeze
  attr_reader :round_num

  def initiate_game
    system 'clear'
    @round_num = 0
    line
    p '|           Weclome to Arkus BlackJack!             |'
    p '|             Standard American rules.              |'
    p '|        Starting cash = 100$  Blind = 10$          |'
    line
  end

  def create_player
    p 'Player name: '
    p_name = gets.chomp
    raise 'Input can not be empty! Try again' if p_name !~ NAME
  rescue RuntimeError => e
    p e.message
    retry
  end

  def round_start
    system 'clear'
    @round_num += 1
    line
    p "Round #{@round_num} start"
    line
  end

  def player_choice
    p 'Hit or Stand?(h/s)'
    choice = ''
    loop do
      choice = gets.chomp.downcase.capitalize!
      break if choice == 'H' || choice == 'S'
      p 'Wrong command, try again! (h/s)'
    end
    CHOICE[choice]
  end

  def player_stand(player)
    p "Player #{player.id} Stand"
  end

  def current_info(player)
    p "Current hand: #{player.hand.join(', ')}"
    p "Cards' value: #{player.current_total}"
    p "Cash - #{player.money}$"
  end

  def dealer_info(dealer)
    p "Dealer hand: #{dealer.hand.join(', ')}"
    p "Dealer cards' value: #{dealer.current_total}"
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
    CHOICE[choice]
  end

  def the_end(money)
    p 'Thanks for playing!'
    p "Your balance after the game: #{money * -1} bucks"
  end

  def new_deck_message
    p 'Loading new deck in shoe!'
  end

  def shuffling_message
    p 'Shuffling the deck!'
  end

  def not_enough_money
    p "You spend all yours' money. So sad."
  end

  def casino_lose
    p "Dealer run out of money! You'r cheater!"
  end

  def line
    p '-----------------------------------------------------'
  end

  def blackjack_message
    line
    p 'BlackJack! You win this round!'
    line
  end

  def player_win_message
    line
    p 'You win this round! '
    line
  end

  def player_lose_message
    line
    p 'Bust! Your bet goes to dealer, good luck next round.'
    line
  end

  def draw_message
    line
    p 'Draw. Bets returned to the owners.'
    line
  end
end
