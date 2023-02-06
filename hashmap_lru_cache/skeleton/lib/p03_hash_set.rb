class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    @store[key.hash] << key
  end

  def include?(key)
    @store.include?(key)
    unless insert(key)
      return false
    end
  end

  def remove(key)
  end

  private

  def [](num)
    @store[num % @num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
