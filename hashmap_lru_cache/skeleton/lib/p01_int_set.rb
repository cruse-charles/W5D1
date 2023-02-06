require 'byebug'

class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num) && !include?(num)
      @store[num] = true
    end
  end

  def remove(num)
    if is_valid?(num) && include?(num)
      @store[num] = false
    end
  end

  def include?(num)
    if is_valid?(num) 
      @store[num] == true
    end
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num < 0 || num > @max
    return true
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :num_buckets
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    i = num % num_buckets
    self[i].delete(num)
  end

  def include?(num)
    i = num % num_buckets
    self[i].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets
  attr_writer :num_buckets

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num
      @count += 1
    end

    if @count >= @num_buckets
      resize!
    end

  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    holder = []
    @store.flatten.each do |el|
      holder << el
    end


    if @count >= @num_buckets
      @num_buckets *= 2
      @store = Array.new(@num_buckets) { Array.new }
      @count = 0
      holder.each do |num|
        insert(num)
      end
    end
  end
end
