require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  test 'validations' do
    participant = participants(:one)
    participant.grade = nil
    assert participant.valid?
    participant.grade = 'hi'
    assert_not participant.valid?
    participant.grade = 1
    assert participant.valid?
  end
  
  test 'leave_team' do
    participant = participants(:one)
    assert_raises( 'Associations exist for this participant.' ) { leave_team }
  end
end
