module GameUI
  NAME = /^[a-zа-я0-9]+$/i

  def play_game
    initiate_game
    run_game
  end

  def initiate_game
    system "clear"
    p '-----------------------------------------------------'
    p '|           Weclome to Arkus BlackJack!             |'
    p '-----------------------------------------------------'
    p ""
    create_player
    @dealer = Dealer.new
    @players.push(@player, @dealer)
  end

  def create_player
    p 'Введите имя игрока: '
    p_name = gets.chomp
    raise 'Имя не может быть пустым! Давайте попробуем еще' if p_name !~ NAME
    @player = Player.new(p_name)
  rescue RuntimeError => e
    p e.message
    retry
  end

  def run_game
    p 'All fine this far'
  end
end
