class ChristmasTree
	attr_reader :root, :sizes
  
	def initialize root
	  @root = root
	  @sizes = get_sizes @root
	end
  
	def show node = @root, depth = 0
	  print "#{' ' * depth}#{node.children.any? ? '*' : '-'} #{node.name} (#{node.size})\n"
	  node.children
      .sort_by { |file| "#{file.children.empty?}" }
      .reverse_each { |child| show child, depth + 2 }
	end
  
	def get_sizes file, sizes = []
    if file.children.any?
      sizes.push file.size
      file.children.each { |child| get_sizes child, sizes }
	  end
  
	  sizes
	end
end
  
class ChristmasNode
	attr_accessor :children, :name, :parent, :size
  
  def initialize children: [], name:, parent: nil, size: 0
    @children = children
    @name = name
    @parent = parent
    @size = size
  end
end
  
module ChristmasTreeBuilder
	@root = nil
  
	def self.parse inputs
	  current = nil
  
	  inputs.each.with_index do |input, current_index|
      case input[0..3]
      when '$ cd'
        if current_index == 0
          @root = ChristmasNode.new name: inputs[0].delete_prefix('$ cd ')
          current = @root
        else
          if input[-2..-1] == '..'
            current = current.parent
          else
            current = current.children.find { |file| file.name == input.delete_prefix('$ cd ') }
          end
        end
      when '$ ls'
        inputs[(current_index + 1)...].each do |line|
          break if line.start_with?('$')
      
          (a, b) = line.split(' ')
      
          child = ChristmasNode.new name: b, parent: current, size: a == 'dir' ? 0 : a.to_i   
          current.children.push(child)
        end
      else
        next
      end
	  end
  
	  self.calculate_sizes @root
  
	  ChristmasTree.new @root
	end
  
	def self.calculate_sizes file
	  file.children.each { |child| calculate_sizes child }
	  file.parent.size += file.size if file.parent
	end
end
  
Array.class_eval do
  def sum_with_condition &block
    self.select(&block).sum
  end

  def smallest_greater_than target
    self.sort.find { |num| num >= target}
  end
end

christmas_tree = ChristmasTreeBuilder.parse(File.readlines('../inputs').map(&:chomp))
free_space = 70000000 - christmas_tree.root.size
deletion_target = 30000000 - free_space

p christmas_tree.sizes.smallest_greater_than deletion_target
