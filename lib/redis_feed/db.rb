module RedisFeed
  class NoRedisError < Exception; end

  class DB
    def self.method_missing method, *args #, &block)
      raise NoRedisError unless Config.redis

      Config.redis.send method, *args
    end
  end
end
