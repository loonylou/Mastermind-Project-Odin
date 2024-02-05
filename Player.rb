class Player
    attr_accessor :name, :role, :human
  
    @@all = []
  
    def initialize (name, role, human)
      @name = name
      @role = role
      @human = human
      @@all << self
    end
  
    def self 
      @@all
    end
  end