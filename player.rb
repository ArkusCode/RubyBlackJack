class Player < Participant
  attr_accessor :id

  def initialize(id)
    super()
    @id = id
  end
end
