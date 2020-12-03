require 'journey'

describe Journey do
  let(:entry) { double :entry }
  subject { Journey.new(entry) }
  it "records entry station" do
    expect(subject.entry).to be entry
  end
end
