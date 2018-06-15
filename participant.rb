class Participant
  attr_accessor :hand, :cur_total, :money
  
  def initialize
    @money = 100
    @hand = []
  end

  def card_value(card) 
    card_value = card.gsub(/\W/, "")
    if card_value.to_i != 0
      card_value
    elsif ["J", "Q", "K"].include?(card_value)
      10
    elsif card_value == "A"
      11
    end
  end

  def calculate_value(total, card)
    card_value = card.gsub(/\W/, "")
    if card_value.to_i != 0
      total += card_value.to_i
    elsif ["J", "Q", "K"].include?(card_value)
      total += 10
    elsif card_value == "A"
      (total + 11) > 21 ? total += 1 : total += 11
    end
    total
  end

  def current_total
    total = 0
    self.hand.each {|card| total = calculate_value(total, card)}
    @cur_total = total
    total
  end
end
