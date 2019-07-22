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
      current = check_input?(el, args, bl=block_given?)
      unless current
        result = false
        break
      end
    end
    result
  end

  def my_any?
    result = false
    self.my_each do |el|
      current = block_given? ? yield(el) : el
      if current
        result = true
        return result
      end
    end
    result
  end

  def my_none?
    result = true
    self.my_each do |el|
      current = block_given? ? yield(el) : el
      if current
        result = false
        return result
      end
    end
    result
  end

  def my_count(*args)
    count = 0

    if args.empty? && !block_given?
      self.my_each do |el|
        count += 1
      end
    elsif block_given?
      self.my_each do |el|
        if yield(el)
          count += 1
        end
      end
    else
      self.my_each do |el|
        if el == args[0]
          count += 1
        end
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

def check_input?(el, args, bl)
  current = nil
  if bl
    current = yield(el)
  elsif args[0]
    current = args[0] === el
  else
    current = el
  end
  current 
end
