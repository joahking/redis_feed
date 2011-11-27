module RedisFeed
  class Reader
    def self.read(inbox, offset = 0, amount = 10)
      #TODO test this
      events = DB.lrange inbox, offset, amount
      events.map { |e| JSON.parse(e) }
    end
  end
end
