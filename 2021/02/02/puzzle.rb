class Submarine
  attr_reader :position

  def initialize
    @aim, @depth, @horizontal_position, @position = 0, 0, 0, 0
  end

  def navigate directions
    directions.each do |direction, amount|
      case direction
      when :forward
        @horizontal_position += amount
        @depth += amount * @aim
      when :up then @aim -= amount
      when :down then @aim += amount
      end
    end
    
    @position = @horizontal_position * @depth
  end
end

directions = File.readlines('../inputs')
.map { |dir| dir.chomp.split(' ') }
.map { |dir| [dir[0].to_sym, dir[1].to_i] }

sub = Submarine.new
sub.navigate directions
puts sub.position
