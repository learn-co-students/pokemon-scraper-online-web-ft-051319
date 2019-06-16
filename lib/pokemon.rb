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
  
   def alter_hp(hp, db)
     sql = "UPDATE pokemon SET hp = ? WHERE id = ?;"
     db.execute(sql, hp, self.id)
   end

 end
