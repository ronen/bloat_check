require 'key_struct'

module BloatCheck
  class Stats < KeyStruct.reader(:memory, :counts, :time)

    def to_s
      "TIME=#{time.is_a?(Numeric) ? "#{time.round(1)} sec" : time} MEM=#{memory} OBJ: #{counts.sort_by(&:last).reverse[0...5].map(&it.join('>')).join(' ')}"
    end

    def log(prefix="")
      BloatCheck.logger.warn("BLOAT[#{$$}] (#{Time.now}) #{prefix} #{self.to_s}") unless BloatCheck.disabled?
    end

    def -(other)
      delta = {}
      counts.each do |klass, count|
        delta[klass] = count - other.counts[klass]
      end
      Stats.new(:memory => self.memory - other.memory, :counts => delta, :time => self.time - other.time)
    end

    def self.get 
      return new(:memory => 0, :counts => {}, :time => 0) if BloatCheck.disabled?

      memory = `ps -o rss= -p #{$$}`.to_i
      counts = Hash.new(0)
      ObjectSpace.each_object do |obj|
        klass = (class << obj ; superclass ; end) # can't use obj.class method since it may be overwritten
        counts[klass] += 1
      end
      self.new(:memory => memory, :counts => counts, :time => Time.now)
    end
  end
end
