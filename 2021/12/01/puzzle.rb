class Cave
  attr_reader :name, :size
  attr_accessor :neighbours, :visited

  def initialize(name, neighbours = [])
    @name = name
    @neighbours = neighbours
    @size = name.downcase == name ? :small : :large
    @visited = false
  end
end

class Network
  attr_reader :caves

  def initialize(cave_list)
    @caves = generate_caves(cave_list)
    @paths = []
  end

  def generate_caves(cave_list)
    caves = []

    cave_list.flatten.uniq.each { |name| caves << Cave.new(name) }

    cave_list.each do |route|
      l = caves.find { |cave| cave.name == route.first }
      r = caves.find { |cave| cave.name == route.last }

      l.neighbours << r
      r.neighbours << l

      [r, l].each { |cave| cave.neighbours = cave.neighbours.uniq }
    end

    caves
  end

  def find_paths
    start = @caves.find { |cave| cave.name == 'start' }
    search(start, [start])
    @paths
  end

  private

  def search(cave, path)
    cave.visited = true if cave.size == :small

    if cave.name == 'end'
      @paths << path.map(&:name)
    else
      cave.neighbours.each do |neighbour|
        next if neighbour.visited

        path << neighbour
        search(neighbour, path)
        path.pop.visited = false
      end
    end
  end
end

routes = File.readlines('../inputs').map { |line| line.chomp.split('-') }

puts Network.new(routes).find_paths.size
