class Dungeon
		attr_accessor :player
		#you want to be able to access player object within the Dungeon class

		def initialize(player_name)
			@player = Player.new(player_name)
			@rooms = []
		end

		def add_room(reference, name, description, connections)
			@rooms.push(Room.new(reference, name, description, connections))
		end

		def start(location)
			@player.location = location #this should be == some :reference in Room
			show_current_description #implicit return here
		end

		def show_current_description
			room = find_room_in_dungeon(@player.location)
			puts room.full_description
		end

		def find_room_in_dungeon(reference)
			@rooms.detect {|room| room.reference == reference}
		end

		def find_room_in_direction(direction)
			find_room_in_dungeon(@player.location).connections[direction]
		end

		def go(direction)
			puts "You go " + direction.to_s
			@player.location = find_room_in_direction(direction)
			show_current_description
		end

	class Player
		attr_accessor :name, :location

		def initialize(player_name)
			@name = player_name			
		end		
	end

	class Room
		attr_accessor :reference, :description, :name, :connections

		def initialize(reference, name, description, connections)
			@reference = reference
			@name = name
			@description = description
			@connections = connections
		end

		def full_description
			@name + "\n\nYou are in " + @description
		end
	end
	
end

my_dungeon = Dungeon.new("Dave")
my_dungeon.add_room(:largecave, "Large Cave", "a really large cave.", {:west => :mystery})
my_dungeon.add_room(:mystery, "mystery", "a mystery room.", {:east => :largecave})

binding.pry