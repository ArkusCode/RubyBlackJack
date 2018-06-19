class Participant
  attr_accessor :hand, :money

  def initialize
    @money = 100
    @hand = []
  end

  def reset
    hand.clear
  end

  def calculate_value(total, card)
    card_value = card.gsub(/\W/, '')
    if card_value.to_i != 0
      total += card_value.to_i
    elsif %w[J Q K].include?(card_value)
      total += 10
    elsif card_value == 'A'
      total += (total + 11) > 21 ? 1 : 11
    end
    total
  end

  def current_total
    total = 0
    hand.each { |card| total = calculate_value(total, card) }
    total
  end
end
