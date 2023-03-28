require "rails_helper" 
describe Participant do

  let(:team) { build(:assignment_team, id: 1, name: 'myTeam') }
  let(:user) { build(:student, id: 4, name: 'no name', fullname: 'no two') }
  let(:team_user) { build(:team_user, id: 1, user: user, team: team) }
  let(:topic) { build(:topic) }
  let(:participant) { build(:participant, user: build(:student, name: 'Jane', fullname: 'Doe, Jane', id: 1)) }
  let(:participant2) { build(:participant, user: build(:student, name: 'John', fullname: 'Doe, John', id: 2)) }
  let(:participant3) { build(:participant, can_review: false, user: build(:student, name: 'King', fullname: 'Titan, King', id: 3)) }
  let(:participant4) { Participant.new }
  let(:assignment) { build(:assignment, id: 1, name: 'no assgt') }
  let(:participant5) { build(:participant, user: user, assignment: assignment) }
  let(:review_response_map) { build(:review_response_map, assignment: assignment, reviewer: participant, reviewee: team) }
  let(:answer) { Answer.new(answer: 1, comments: 'Answer text', question_id: 1) }
  let(:response) { build(:response, id: 1, map_id: 1, response_map: review_response_map, scores: [answer]) }
  let(:question1) { Criterion.new(id: 1, weight: 2, break_before: true) }
  let(:question2) { Criterion.new(id: 2, weight: 2, break_before: true) }
  let(:questionnaire1) { ReviewQuestionnaire.new(id: 1, questions: [question1], max_question_score: 5) }
  let(:questionnaire2) { ReviewQuestionnaire.new(id: 2, questions: [question2], max_question_score: 5) }


    after(:each) do
      ActionMailer::Base.deliveries.clear
    end
    
    describe '#team' do
      it 'returns the team of the participant' do
        allow(participant4).to receive(:user).and_return(user)
        allow(TeamsUser).to receive(:find_by).with(user: user).and_return(team_user)
        expect(participant4.team).to eq(team)
      end
    end

    describe '#leave_team' do
      it 'deletes a participant if no associations exist and force is nil' do
        expect(participant.delete(nil)).to eq(participant)
      end
      it 'deletes a participant if no associations exist and force is true' do
        expect(participant.delete(true)).to eq(participant)
      end
      it 'delete a participant with associations and force is true and multiple team_users' do
        allow(participant).to receive(:team).and_return(team)
        expect(participant.delete(true)).to eq(participant)
      end
    end

    describe '#name' do
      it 'returns the name of the user' do
        expect(participant.name).to eq('Jane')
      end
    end
  
    describe '#fullname' do
      it 'returns the full name of the user' do
        expect(participant.fullname).to eq('Doe, Jane')
      end
    end

    describe '#handle' do
      it 'returns the handle of the participant' do
        expect(participant.handle(nil)).to eq('handle')
      end
    end

    
    describe '#sort_by_name' do
      it 'returns a sorted list of participants alphabetical by name' do
        unsorted = [participant3, participant, participant2]
        sorted = [participant, participant2, participant3]
        expect(Participant.sort_by_name(unsorted)).to eq(sorted)
      end
    end
 
    describe '#topic_name' do
      it 'returns the participant topic name when nil' do
        expect(participant.topic_name).to eq('<center>&#8212;</center>')
      end
      it 'returns the participant topic name when not nil' do
        allow(participant).to receive(:topic).and_return(topic)
        expect(participant.topic_name).to eq('Hello world!')
      end
    end


    describe '#authorization' do
      it 'returns participant when no arguments are passed' do
        allow(participant).to receive(:can_submit).and_return(nil)
        allow(participant).to receive(:can_review).and_return(nil)
        allow(participant).to receive(:can_take_quiz).and_return(nil)
        expect(participant.authorization).to eq('participant')
      end
      it 'returns reader when no arguments are passed' do
        allow(participant).to receive(:can_submit).and_return(false)
        allow(participant).to receive(:can_review).and_return(true)
        allow(participant).to receive(:can_take_quiz).and_return(true)
        expect(participant.authorization).to eq('reader')
      end
      it 'returns submitter when no arguments are passed' do
        allow(participant).to receive(:can_submit).and_return(true)
        allow(participant).to receive(:can_review).and_return(false)
        allow(participant).to receive(:can_take_quiz).and_return(false)
        expect(participant.authorization).to eq('submitter')
      end
      it 'returns reviewer when no arguments are passed' do
        allow(participant).to receive(:can_submit).and_return(false)
        allow(participant).to receive(:can_review).and_return(true)
        allow(participant).to receive(:can_take_quiz).and_return(false)
        expect(participant.authorization).to eq('reviewer')
      end
    end
  
    describe '#export_fields' do
        # let(:participant) { create(:participant) }
        let(:options) { { 'personal_details' => 'true', 'role' => 'true', 'parent' => 'true', 'email_options' => 'true', 'handle' => 'true' } }
        it 'returns the participant data in the correct format' do
          expected_result = "name", "full name", "email", "role", "parent", "email on submission", "email on review", "email on metareview", "handle"
          expect(Participant.export_fields(options)).to eq(expected_result)
        end
      end

      it '#export' do
        csv = []
        parent_id = 1
        options = nil
        allow(Participant).to receive_message_chain(:where, :find_each).with(parent_id: 1).with(no_args).and_yield(participant)
        allow(participant).to receive(:user).and_return(build(:student, name: 'student2065', fullname: '2065, student'))
        options = { 'personal_details' => 'true', 'role' => 'true' }
        expect(Participant.export([], 1, options)).to eq(
          [['student2065',
            '2065, student',
            nil,
            nil]]
        )
      end
    
end
  
