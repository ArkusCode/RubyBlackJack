class Bank
  attr_reader :bet

  def initialize
    @bet = 10
  end

  def win(player)
    player.money += @bet
  end

  def bust(player)
    player.money -= @bet
  end
end
