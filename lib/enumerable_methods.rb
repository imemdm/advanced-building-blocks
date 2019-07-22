module Enumerable
  def my_each
    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    self.my_each do |el|
      result << el if yield(el)
    end
    result
  end

  def my_all?(*args)
    result = true
    self.my_each do |el|
      current = block_given? ? yield(el) : handle_args(el, args)
      unless current
        result = false
        break
      end
    end
    result
  end

  def my_any?(*args)
    result = false
    self.my_each do |el|
      current = block_given? ? yield(el) : handle_args(el, args)
      if current
        result = true
        break
      end
    end
    result
  end

  def my_none?(*args)
    result = true
    self.my_each do |el|
      current = block_given? ? yield(el) : handle_args(el, args)
      if current
        result = false
        break
      end
    end
    result
  end

  def my_count(*args)
    count = 0

    self.my_each do |el|
      if block_given?
        count += 1 if yield(el)
      elsif args[0]
        count += 1 if args[0] == el
      else
        count += 1
      end
    end
    count
  end

  def my_map(&block)
    result = []

    self.my_each do |el|
      result << block.call(el)
    end
    result
  end

  def my_inject(*args)
    memo = args[0] && args[0].is_a?(Numeric) ? args[0] : nil

    self.my_each do |el|
      if memo.nil?
        memo = el
        next
      end
      if block_given?
        memo = yield(memo, el)
      else
        meth = args.size == 2 ? args[1] : args[0]
        memo = memo.send(meth, el)
      end
    end
    memo
  end

  # helper
  def handle_args(el, args)
    current = args[0] ? args[0] === el : el
  end
end



def multiply_els arr
  arr.my_inject(1, :*)
end