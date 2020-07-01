class Foo
  def initialize(bar)
    @bar = bar
  end

  def test1
    puts @bar
  end

  alias_method :test2, :test1
end

foo = Foo.new(1)
test1 = foo.method(:test1)
test2 = foo.method(:test2)
puts test1 == test2

puts "name: #{test2.name}"
puts "original_name: #{test2.original_name}"
test2.call

test2_instance_method = Foo.instance_method(:test2)
puts test2_instance_method.respond_to?(:call)
puts test2.unbind == test2_instance_method

another_foo = Foo.new(42)
test2_instance_method.bind(another_foo).call

class Hoge
  def initialize(val)
    @val = val
  end

  def fuga(arg)
    puts arg
    puts '割り切れました' if @val % arg == 0
  end
end

target_number = 420
hoge = Hoge.new(target_number)
fuga = hoge.method(:fuga)
1.upto(100).each(&fuga)
