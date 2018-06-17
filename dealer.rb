class Dealer < Participant
  attr_reader :id

  def initialize
    super()
    @id = 'Dealer'
  end
end
