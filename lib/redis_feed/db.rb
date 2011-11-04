module RedisFeed
  class DB
    def self.method_missing method, *args #, &block)
      Config.redis.send method, *args
    end
  end
end
