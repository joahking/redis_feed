module RedisFeed
  class Reader
    def self.read(inbox)
      #TODO test this
      DB.lrange inbox, 0, 10
    end
  end
end
