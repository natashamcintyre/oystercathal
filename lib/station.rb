class Station
  attr_reader :name, :zone

  def initialize(hash)
    @name = hash[:name]
    @zone = hash[:zone]
  end

end
