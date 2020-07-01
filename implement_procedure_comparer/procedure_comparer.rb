class ProcedureComparer
  class ComparationFailed < StandardError ; end
  
  def initialize(left, right)
    @left = left
    @right = right
  end

  def compare(&block)
    raise ComparationFailed unless either_callable?

    block ||= method(:default_block)
    block.call @left.call, @right.call
  end

  private

  def either_callable?
    @left.respond_to?(:call) && @right.respond_to?(:call)
  end

  def default_block(left, right)
    "#{left} vs #{right}"
  end
end
