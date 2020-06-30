require 'minitest/autorun'
require_relative 'procedure_comparer'

class ProcedureComparerTest < Minitest::Test
  def test_with_procs
    proc1 = Proc.new { 1 }
    proc2 = proc { 2 }
    comparer = ProcedureComparer.new(proc1, proc2)
    assert_equal "1 vs 2", comparer.compare
  end

  def test_proc_and_lambda
    p = Proc.new { 1 }
    l = lambda { 2 }
    comparer = ProcedureComparer.new(p, l)
    assert_equal "1 vs 2", comparer.compare
  end

  def test_proc_and_method
    proc = Proc.new { 1 }
    method = "2".method(:to_i)
    comparer = ProcedureComparer.new(proc, method)
    assert_equal "1 vs 2", comparer.compare
  end

  def test_proc_and_unbound_method
    proc = Proc.new { 1 }
    method = String.instance_method(:to_i)
    comparer = ProcedureComparer.new(proc, method)
    assert_raises(ProcedureComparer::ComparationFailed) { comparer.compare }
  end

  def test_changing_output_with_block
    skip
    proc1 = Proc.new { 1 }
    proc2 = proc { 2 }
    comparer = ProcedureComparer.new(proc1, proc2)
    assert_equal "left: 1\nright: 2", (comparer.compare do |left, right|
      "left: #{left}\nright: #{right}"
    end)
  end
end
