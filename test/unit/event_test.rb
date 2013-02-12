require 'minitest_helper'

class EventTest < MiniTest::Unit::TestCase
  def setup
    @event = Event.new
  end

  def test_future_if_event_not_happened
    @event.starting_at = Time.now + 1.month
    assert @event.future?
  end

  def test_future_if_event_happened
    @event.starting_at = Time.now - 1.month
    refute @event.future?
  end

  def test_closest_upcoming
    event1 = FactoryGirl.create(:event, starting_at: (Time.now + 1.month))
    event2 = FactoryGirl.create(:event, starting_at: (Time.now + 2.months))
    closest = Event.closest_upcoming

    assert_equal closest, event1
  end  
end