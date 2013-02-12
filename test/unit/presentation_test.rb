require 'minitest_helper'

class PresentationTest < MiniTest::Unit::TestCase
  def setup
    @presentation = Presentation.create(title: "DRUG fact - It's an anarchy")
  end

  def test_postponing
    refute @presentation.postponed?

    @presentation.postpone!
    assert @presentation.postponed?

    @presentation.cancel_postponement!
    assert_equal @presentation.status, 'submitted'
  end

  def test_speakers
    speaker1 = Person.create
    speaker2 = Person.create

    @presentation.speakers << speaker1
    @presentation.speakers << speaker2

    assert @presentation.speakers.size, 2
    assert_equal @presentation.lead_speaker, speaker1
  end
end