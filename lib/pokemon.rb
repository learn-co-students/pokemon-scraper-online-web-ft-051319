class Pokemon

    attr_accessor :name, :type, :hp
    attr_reader :id, :db 

    def initialize(id:, db:, name:, type:, hp: nil)
        @id = id
        @db = db
        @name = name
        @type = type
        @hp = hp
    end

    def alter_hp(new_hp, db)
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", new_hp, @id)
    end

    def self.save(name, type, db)
        db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    end

    def self.find(id, db)
        row = db.execute("SELECT * FROM pokemon WHERE pokemon.id = ?", id).flatten
        @name = row[1]
        @type = row[2]
        @hp = row[3]

        Pokemon.new(id: id, db: db, name: @name, type: @type, hp: @hp)
    end


end
