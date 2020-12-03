require 'station'

describe Station do

  subject {described_class.new(name: "Covent Garden", zone: 2)}

  it { is_expected.to respond_to(:name) }

  it { is_expected.to respond_to(:zone) }

  it 'knows the name' do
    expect(subject.name).to eq "Covent Garden"
  end

  it 'knows the zone' do
    expect(subject.zone).to eq 2
  end
end
