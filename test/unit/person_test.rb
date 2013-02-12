require 'minitest_helper'

class PersonTest < MiniTest::Unit::TestCase
  def setup
    @person = Person.create
  end

  def test_attend
    @event = FactoryGirl.create(:event)

    refute @person.attend?(@event)

    @person.attend!(@event)
    refute_empty Participation.where(person_id: @person.id, event_id: @event.id)

    assert @person.attend?(@event)

    assert_raises Person::AlreadySignedException do
      @person.attend!(@event)
    end
  end

  def test_membership
    # shoud be unpublicized by default
    refute @person.publicized?

    @person.change_membership!
    assert @person.publicized?

    @person.change_membership!
    refute @person.publicized?
  end

  def test_amount_of_presentations
    submitted = FactoryGirl.create(:presentation, speakers: [@person], status: 'submitted')
    postponed = FactoryGirl.create(:presentation, speakers: [@person], status: 'postponed')
    done = FactoryGirl.create(:presentation, speakers: [@person], status: 'done')

    assert_equal @person.amount_of_presentations, 1
    assert_equal @person.karma, Person::PresentationsKarma
  end
end