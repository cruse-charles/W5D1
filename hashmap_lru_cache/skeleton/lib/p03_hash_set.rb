require 'byebug'

class HashSet
  attr_reader :count
  attr_accessor :num_buckets
  

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    if !include?(key)
      self[key.hash] << key
      @count += 1
    end

    if @count >= @num_buckets
      resize!
    end
    
  end

  def include?(key)

    return true if self[key.hash].include?(key)

    false
  end

  def remove(key)
    
    if include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    holder = []

    @store.flatten.each do |ele|
      holder << ele
    end

    @num_buckets *= 2
    @store = Array.new(num_buckets) {Array.new}
    @count = 0
 
    holder.each do |ele|
      insert(ele)
    end
  end
end
