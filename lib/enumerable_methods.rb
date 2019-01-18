module Enumerable
  def my_each
    len = self.length - 1
    for i in 0..len
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    len = self.length - 1
    for i in 0..len
      yield(self[i], i)
    end
    self
  end

  def my_select
    result = []
    self.my_each_with_index do |el, i|
      if yield(el)
        result << self[i]
      end
    end
    result
  end

  def my_all?
    result = true
    self.my_each do |el|
      current = block_given? ? yield(el) : el
      unless current
        result = false
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


