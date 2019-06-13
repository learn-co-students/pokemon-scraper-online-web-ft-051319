class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id
  
  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end
  
  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name,type)
  end
  
  def self.find(num, db)
    pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?", [num])
    id = pokemon[0][0]
    name = pokemon[0][1]
    type = pokemon[0][2]
    hp = pokemon[0][3]
    new_pokemon = self.new(id: id, name: name, type: type, db: db, hp: hp)
    return new_pokemon
  end
  
  def alter_hp(num, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", [num], [self.id])
    self.hp = num
  end
end
