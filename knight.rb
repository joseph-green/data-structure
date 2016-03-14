class Board
	@@width = 8
	@@height = 8
	attr_accessor :knight
	def initialize knight = Knight.new([3,3])
		@knight = knight
	end
	def self.possible_move? move
		return false if move[0] >= @@width || move[1] >= @@height
		return true
	end
end
class Knight
	attr_reader :position, :x, :y, :previous, :generation
	attr_accessor  :next
	def initialize position = [3,3], previous = nil
		@position = position
		@x = position[0]
		@y = position[1]
		@previous = previous
		@next = nil
		@generation = @previous == nil ? 0 : @previous.generation + 1
	end
	def possible_moves
		possible_moves = Array.new
		possible_moves << [@x + 1,@y + 2]
		possible_moves << [@x + 1,@y - 2]
		possible_moves << [@x - 1,@y + 2]
		possible_moves << [@x - 1,@y - 2]
		possible_moves << [@x + 2,@y + 1]
		possible_moves << [@x + 2,@y - 1]
		possible_moves << [@x - 2,@y + 1]
		possible_moves << [@x - 2,@y - 1]
		possible_moves.select {|x| Board.possible_move? x}
		possible_moves.map {|x| Knight.new [x[0],x[1]], self }

	end
end
def knight_moves destination, start
	knight = Knight.new start
	board = Board.new knight
	queue = Array.new 

	knight.next = knight.possible_moves
	knight.next.each {|x| queue << x}
	while queue.length > 0
		
		if queue.first.position == destination
			puts "Found the shortest path! (#{queue.first.generation} moves)"
			puts "Here's the path to #{destination}:"			
			previous = queue.first.previous
			path = Array.new
			while previous != nil
				path << "[#{previous.x},#{previous.y}]"
				previous = previous.previous

			end
			path.reverse.each {|x| puts x}
			puts "[#{queue.first.x},#{queue.first.y}]"
			break
		end 
		queue.first.next = queue.first.possible_moves
		queue.first.next.each {|x| queue << x}
		queue.delete queue.first
	end

end
knight_moves [7,7], [6,2]
knight_moves [1,3], [4,5]
knight_moves [3,4], [1,7]