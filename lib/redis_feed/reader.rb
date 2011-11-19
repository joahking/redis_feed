module RedisFeed
  class Reader
    def self.read(inbox, offset = 0, amount = 10)
      #TODO test this
      DB.lrange inbox, offset, amount
    end
  end
end
