class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  
  def initialize(id: nil, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end
  
  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      LIMIT 1;
    SQL
    db.execute(sql, id).map do |row|
      new_pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])
      new_pokemon
    end.first
  end
  
#   def alter_hp(name, db, type, hp)
#     sql = "SELECT * FROM pokemon WHERE name = ? LIMIT 1;"
#     pokemon_array = db.execute(sql, name)
#     pokemon_array.map do |row|
#       id = row[0]
#       name = row[1]
#       type = row[2]
#       sql = "UPDATE pokemon SET name = ?, type = ?, hp = ? WHERE id = ?;"
#       db.execute(sql, name, type, hp, id)
#     end
#   end

 end
