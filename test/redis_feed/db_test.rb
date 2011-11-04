require 'test_helper'

module RedisFeed
  describe DB do
    describe "with no redis configured" do
      it "must raise NoRedisError" do
        lambda { DB.any_method }.must_raise(RedisFeed::NoRedisError)
      end
    end
  end
end
