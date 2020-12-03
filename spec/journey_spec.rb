require 'journey'

describe Journey do
  let(:station) { double :station }
  subject { Journey.new(station) }
  it "records entry station" do
    expect(subject.entry_station).to be station
  end

  it 'records exit station' do
    subject.finish_journey(station)
    expect(subject.exit_station).to be station
  end

  describe '#fare' do
    it "returns journey fare" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
