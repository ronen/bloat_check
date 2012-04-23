module BloatCheck
  module WrapRequests
    def self.included(klass)
      klass.class_eval do
        before_filter :init_bloat_stats
        after_filter :dump_bloat_stats
      end
    end

    def init_bloat_stats
      @bloat_start = Stats.get
    end

    def dump_bloat_stats
      (Stats.get - @bloat_start).log("REQ=#{request.method.inspect} URL=#{request.url.inspect}")
    end
  end
end
