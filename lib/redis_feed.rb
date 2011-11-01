require "redis_feed/version"

module RedisFeed
  module Source

    def self.included(base)
      base.class_eval do
        after_save :push_event_to_readers
      end
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def outboxes
        "fs/#{id}/o"
      end

      def subscribe(reader)
        $redis.sadd outboxes, reader
      end

      def readers
        $redis.smembers outboxes
      end

      def push_event_to_readers
        readers.each do |reader|
          $redis.lpush reader, event
        end
      end

      def event
        # o means object, # e means event
        e = {:o => self.class.to_s, :id => self.id, :e => 'created'}
        # u means user
        e[:u] = @current_user.id if @current_user
        e.to_json
      end
    end

  end
end
