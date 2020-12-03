require 'journey'

describe Journey do
  let(:station) { double :station }
  subject { Journey.new(station) }
  it "records entry station" do
    expect(subject.entry_station).to be station
  end

  it 'records exit station' do
    subject.finish(station)
    expect(subject.exit_station).to be station
  end
end
