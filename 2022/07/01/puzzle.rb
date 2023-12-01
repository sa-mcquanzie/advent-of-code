class ElfFile
  attr_accessor :name, :size, :children, :parent

  def initialize(name:, size: 0, parent: nil, children: [])
    @name = name
    @size = size
    @children = children
    @parent = parent
  end

  def directory?
    !children.empty?
  end

  def info
    print directory? ? '* ' : ''
    puts @name
    puts @size
    puts children.map(&:info)
  end
end

testfile1 = ElfFile.new(name:'testfile1', size:10)
testfile2 = ElfFile.new(name:'testfile2', size:20)
testfile3 = ElfFile.new(name:'testfile3', size:30)
testdir2 = ElfFile.new(name: 'testdir2', children:[testfile2, testfile3])
testdir1 = ElfFile.new(name: 'testdir1', children: [testfile1, testdir2])
testdir2.parent = testdir1

testdir1.info
