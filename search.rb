class Node
	@@node_quantity = 0 
	attr_accessor :value, :parent, :childLeft, :childRight
	def initialize value, parent
		@value = value 
		@parent = parent
		@childLeft = nil
		@childRight = nil
		@@node_quantity += 1
	end
	def addChild child
		nil unless child.is_a?(Integer)
		if child < @value
			@childLeft == nil ? @childLeft = Node.new(child,self) : @childLeft.addChild(child)  
		else
			@childRight == nil ? @childRight = Node.new(child,self) : @childRight.addChild(child)  
		end
	end
	def self.getNodes
		@@node_quantity
	end
end

def binary_tree array
	stump = Node.new(array.first,nil)
	puts "Binary Tree Stump: #{stump.value}" 
	array.each {|x| stump.addChild(x)}
	return stump
	



end
def breadth_first_search value, tree
	queue = Array.new
	searched = Array.new
	current = tree
	while searched.length < Node.getNodes
		if current.value == value
		puts "Found the value #{current.value}"
		return current
		end
		queue << current.childLeft unless searched.include?(current.childLeft)
		queue << current.parent unless searched.include?(current.parent)
		queue << current.childRight unless searched.include?(current.childRight)
	
		searched << queue.first
		queue.delete(queue.first)	
		current = queue.first
	end
	puts "Could not find the value #{value}, sorry."
end
def depth_first_search value, tree
	stack = Array.new
	searched = Array.new 
	current = tree
	puts current
	while searched.length < Node.getNodes
		
		if current.value == value
		puts "Found the value #{current.value}"
		return current
		end	
		searched << stack

		loop do
			if !(searched.include?(current.childLeft) || stack.include?(current.childLeft))
			stack << current.childLeft 
			current = stack.last
			break
			elsif !(searched.include?(current.parent) || stack.include?(current.parent) || stack.include?(current.parent))
				stack << current.parent 
				current = stack.last
				break
			elsif !(searched.include?(current.childRight) || stack.include?(current.childRight))
				stack << current.childRight
				current = stack.last
				break
			else
				stack.delete(stack.last)
				current = stack.last
			end
		end


	end 
	puts "Could not find the value #{value}, sorry."
end
start = binary_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
breadth_first_search 6345, start
depth_first_search 6345, start
