require "pry"

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp:60) #had to add the hp argument for alter_hp to work
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO pokemon (name, type)
    VALUES (? ,?)
    SQL

    db.execute(sql, name, type)

    @id = db.execute("SELECT last_insert_rowid() from pokemon")[0][0]
  end

  def self.find(pokemon_id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?
    SQL

    row = db.execute(sql, pokemon_id)[0]
    pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3]) #had to add the hp setter here for BONUS
    pokemon
  end

  def alter_hp(hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE id = ?"
    db.execute(sql, hp, self.id) #updates the hp attribute in the SQL table, but after this need to modify the find method
    #at this point the table already has a hp column but the pokemon object that we create in the find method needs to
    #reflect this as well
  end




end
