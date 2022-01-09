class City
  attr_accessor :name, :abbr
  CITIES = [
    {name: 'New York City', abbr: 'NYC'},
    {name: 'Atlanta', abbr: 'Atlanta'},
    {name: 'Los Angeles', abbr: 'LA'}
  ].freeze

  def self.find(name)
    CITIES.find{|city| city[:name].downcase == name.downcase || city[:abbr].downcase == name.downcase }
  end

end
