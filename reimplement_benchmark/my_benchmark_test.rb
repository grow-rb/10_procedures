require 'minitest/autorun'
require_relative 'my_benchmark'

class MyBenchmarkTest < Minitest::Test
  def test_benchmark_with_procs
    proc1 = Proc.new { sleep 0.1 }
    proc2 = Proc.new { sleep 0.2 }
    benchmark = MyBenchmark.new
    assert_equal "left is faster", benchmark.bm(proc1, proc2)
  end

  def test_benchmark_with_proc_and_method
    proc = Proc.new { sleep 0.1 }
    method = "str".method(:upcase!)
    benchmark = MyBenchmark.new
    assert_equal "right is faster", benchmark.bm(proc, method)
  end

  def test_benchmark_with_same_unbound_method_with_difference_object
    require 'prime'
    method = Integer.instance_method(:prime?)
    small_int = 42
    big_int = 83787854773258728577
    benchmark = MyBenchmark.new
    assert_equal "left is faster", benchmark.bm_instances(small_int, big_int, method: method)
  end
end
