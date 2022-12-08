class ElfFile
  attr_accessor :children, :name, :parent, :size

  @@current = nil

  def initialize(children: [], name:, parent: nil, size: 0)
    @children = children
    @name = name
    @parent = parent
    @size = size
  end

  def self.current() = @@current

  def self.current=(elf_file)
    @@current = elf_file
  end
end

root = ElfFile.new(name: '*', children: [ElfFile.new(name: '/')])
ElfFile.current = root
console = File.readlines('../inputs').map(&:chomp)[0..40]

console.each.with_index do |input, current_index|
  case input[0..3]
  when "$ cd"
    print "\nChanging directory to "

    if input[-2..-1] == '..'
      ElfFile.current = ElfFile.current.parent
    else
      ElfFile.current = ElfFile.current.children.find { |file| file.name == input[5..-1] }
    end

  print ElfFile.current.name + "\n"
  when "$ ls"
    puts

    next_command_index = console.index { |line| console.index(line) > current_index && line.start_with?('$') }

    console[(current_index + 1)...next_command_index].each do |filename|
      next if filename.start_with? '$'

      (part1, part2) = filename.split(' ')
      child = ElfFile.new(name: part2, parent: ElfFile.current, size: part1 == 'dir' ? 0 : part1.to_i)

      ElfFile.current.children.push child
      ElfFile.current.size += child.size
    end

    puts ElfFile.current.children.sort_by { |attr| [attr.size, attr.name] }.map { |child| "#{child.name} #{child.size}" }
  end
end
