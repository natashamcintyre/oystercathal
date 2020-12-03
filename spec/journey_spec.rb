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
      allow(subject).to receive(:complete_journey?) { false }
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare when valid journey?' do
      allow(subject).to receive(:complete_journey?) { true }
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
  end

  describe '#complete_journey?' do
    subject { Journey.new }
    it 'returns true when a journey has a start and an end station' do
      subject.entry_station = 'Victoria'
      subject.exit_station = 'Kings Cross'
      expect(subject.complete_journey?).to eq true
    end

    it 'returns false when a journey has a start but no end station' do
      subject.entry_station = 'Victoria'
      expect(subject.complete_journey?).to eq false
    end

    it 'returns false when a journey has no start and an end station' do
      subject.exit_station = 'Kings Cross'
      expect(subject.complete_journey?).to eq false
    end
  end
end
