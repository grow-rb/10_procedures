proc = Proc.new { 1 }
p proc.lambda?
puts "\n"

class Foo
  def initialize(proc_or_lambda)
    @proc_or_lambda = proc_or_lambda
  end

  def bar
    puts @proc_or_lambda.call
  end

  def baz(*args)
    puts @proc_or_lambda[*args] # call
  end
end

def test1
  puts __method__
  p = Proc.new { return 1 }
  foo = Foo.new(p)
  foo.bar
end

def test2
  puts __method__
  p = proc { next 1 }
  foo = Foo.new(p)
  foo.bar
end

def test3
  puts __method__
  p = proc { break 1 }
  foo = Foo.new(p)
  foo.bar

rescue LocalJumpError => e
  puts e.inspect
end

def test4
  puts __method__
  lambda1 = -> { return 1 }
  foo = Foo.new(lambda1)
  foo.bar
end

def test5
  puts __method__
  lambda1 = lambda { next 1 }
  foo = Foo.new(lambda1)
  foo.bar
end

def test6
  puts __method__
  lambda1 = lambda { break 1 }
  foo = Foo.new(lambda1)
  foo.bar
end

def test7
  puts __method__
  proc1 = Proc.new {|arg1| next(arg1 || 'No arg') }
  foo = Foo.new(proc1)
  foo.baz(1, 2, 3) # extra args
  foo.baz # no arg
end

def test8
  puts __method__
  l = ->(arg1) { next arg1 }
  foo = Foo.new(l)
  foo.baz(1, 2, 3)

rescue ArgumentError => e
  puts e.inspect
end

def test9
  puts __method__
  l = ->(arg1) { next arg1 }
  foo = Foo.new(l)
  foo.baz

rescue ArgumentError => e
  puts e.inspect
end

class Hoge
  def fuga
    puts yield if block_given?
  end
end

def test10
  puts __method__
  Hoge.new.fuga do
    return 1
  end
end

def test11
  puts __method__
  Hoge.new.fuga do
    next 1
  end
end

def test12
  puts __method__
  Hoge.new.fuga do
    break 1
  end
end

1.upto(12).each {|i| self.__send__ "test#{i}"; puts "\n"}
