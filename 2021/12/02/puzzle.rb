class Cave
    attr_reader :name, :size, :terminus
    attr_accessor :max_visits, :neighbours, :visits
  
    def initialize(name, neighbours = [])
      @name = name
      @neighbours = neighbours
      @size = name.downcase == name ? :small : :large
      @terminus = ['start', 'end'].include?(@name)
      @visits = 0
      @max_visits = @size == :small ? 1 : Float::INFINITY
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

      @caves.each do |cave|
        if cave.size == :small && !cave.terminus
          cave.max_visits = 2
          search(start, [start])
          cave.max_visits = 1
          @caves.each { |c| c.visits = 0 }
        end
      end

      @paths.uniq
    end
  
    private
  
    def search(cave, path)
      cave.visits += 1
  
      if cave.name == 'end'
        @paths << path.map(&:name)
      else
        cave.neighbours.each do |neighbour|
          next if neighbour.visits == neighbour.max_visits
          
          path << neighbour
          search(neighbour, path)
          path.pop.visits -= 1
        end
      end
    end
  end
  
  routes = File.readlines('../inputs').map { |line| line.chomp.split('-') }
  
  puts Network.new(routes).find_paths.size
  