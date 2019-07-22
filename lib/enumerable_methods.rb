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

  def my_inject(memo = nil)  
    self.my_each do |el|
      if memo.nil?
        memo = 0
      end
      memo = yield(memo, el)
    end
    memo
  end

  def multiply_els arr
    arr.my_inject(1) do |sum, el|
      sum * el
    end
  
  end
end

def handle_args(el, args)
  current = args[0] ? args[0] === el : el
end
