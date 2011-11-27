module RedisFeed
  module Source

    def self.included(base)
      base.class_eval do
        #TODO subscribe an object to itself
        after_save :push_event_to_readers
      end
      base.send :include, InstanceMethods
    end

    module InstanceMethods
      def rf_events
        # es = []
        RedisFeed::Reader.read(inbox) # .each do |e|
        #   es << JSON.parse(e)
        # end
        # es
      end

      def rf_event!(e = _rf_event)
        push_event_to_readers e.to_json
      end

      def subscribe(reader)
        DB.sadd outboxes, reader
      end

      def readers
        DB.smembers outboxes
      end

      # -----------------

      #TODO make the separator "/" configurable
      def feed_key
        "#{_rf_name}/#{_rf_id}"
      end

      def _rf_name
        #you might want a shorter key name
        self.class.to_s
      end

      def _rf_id
        self.id
      end

      # -----------------

      def outboxes
        "#{feed_key}/o"
      end

      def inbox
        "#{feed_key}/i"
      end

      # -----------------

      def push_event_to_readers(event = _rf_event)
        readers.each do |reader|
          push reader, event
        end
      end

      def push(reader, event = _rf_event)
        DB.lpush reader, event
      end

      def _rf_event
        event = (self.created_at == self.updated_at) ? 'created' : 'updated'
        # o means object, # e means event
        e = {:o => self.class.to_s, :id => self.id, :on => self.name, :e => event}
        # u means user
        if @current_user
          e[:u] = @current_user.id
          e[:un] = @current_user.username
        end
        e.to_json
      end

    end

  end
end
