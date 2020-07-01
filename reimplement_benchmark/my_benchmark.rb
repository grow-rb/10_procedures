class MyBenchmark
  def bm(left, right)
    left = BenchmarkedProcedure.new('left', left)
    right = BenchmarkedProcedure.new('right', right)

    output_faster(left, right)
  end

  def bm_instances(left, right, method:)
    left = method.bind(left)
    right = method.bind(right)

    bm(left, right)
  end

  private

  def output_faster(left, right)
    "#{[left, right].min.name} is faster"
  end
end

class BenchmarkedProcedure
  attr_reader :name, :time

  def initialize(name, callable)
    @callable = callable
    @name = name
    @time = benchmark
  end

  def <=>(arg)
    time.<=>(arg.time)
  end

  private

  def benchmark
    start = Time.now
    @callable.call
    Time.now - start
  end
end