module RedisFeed
  class Reader
    def self.read(inbox)
      $redis.lrange inbox, 0, 10
    end
  end
end
