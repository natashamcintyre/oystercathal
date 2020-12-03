require "oystercard"

describe Oystercard do
  let(:entry) { double :station }
  let(:exit) { double :station }
  # it "can create an instance of oystercard" do
  #   expect(subject).to be_kind_of(Oystercard)
  # end
  it { is_expected.to respond_to(:balance) }
  # it "responds to the method balance" do
  #   expect(subject).to respond_to(:balance)
  # end

  it "gives a default balance of 0" do
    expect(subject.balance).to eq 0
  end

  it "responds to the method top_up" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  describe "#top_up" do
    it "increases balance by amount" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "raises an error when top up exceeds #{Oystercard::LIMIT}" do
      message = "Balance cannot exceed #{Oystercard::LIMIT}"
      expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error message
    end
  end

  # describe '#deduct' do
  #   it 'reduces balance by amount' do
  #     subject.top_up(50)
  #     subject.deduct(5)
  #     expect(subject.balance).to eq 45
  #   end
  # end
  it { is_expected.to respond_to(:touch_in) }
  # it "responds to the method touch_in" do
  #   expect(subject).to respond_to(:touch_in)
  # end

  describe "#touch_in" do
    it "sets card state to in journey" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
      expect(subject).to be_in_journey
    end

    it "raises error if balance is under MIN_FARE" do
      expect { subject.touch_in(entry) }.to raise_error "Insufficient funds"
    end

    it 'if the user did not manually touch_out, it will do it for them' do
      subject.top_up(Journey::PENALTY_FARE + 1)
      subject.touch_in(entry)
      expect{ subject.touch_in(entry) }.to change { subject.history }
    end

  end
  it { is_expected.to respond_to(:in_journey?) }
  # it "responds to the method in_journey?" do
  #   expect(subject).to respond_to(:in_journey?)
  # end

  describe "#in_journey?" do
    it "returns true when in journey" do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
      expect(subject).to be_in_journey
    end

    it "returns false when not in journey" do
      expect(subject).not_to be_in_journey
    end
  end
  it { is_expected.to respond_to(:touch_out) }
  # it "responds to the method touch_out" do
  #   expect(subject).to respond_to(:touch_out)
  # end

  describe "#touch_out" do
    before(:each) do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry)
    end
    it "sets card state to not in journey" do
      subject.touch_out(exit)
      expect(subject).not_to be_in_journey
    end

    it "deducts journey fare from balance" do
      expect { subject.touch_out(exit) }.to change { subject.balance }
    end

    it 'saves a journey to card history' do
      expect{ subject.touch_out(exit) }.to change { subject.history }
    end

    it 'will retroactively touch user in if they did not do it before' do
      subject.top_up(Journey::PENALTY_FARE)
      expect{ subject.touch_out(exit) }.to change { subject.history }
    end

    # let(:journey) { double :current_journey }
    # it 'passes exit station to journey class' do
    #   allow(journey).to receive(:finish_journey).and_return(exit)
    #   expect(subject.touch_out(exit)).to eq exit
    # end

  end

  it "stores journeys in history" do
    subject.top_up(15)
    subject.touch_in(entry)
    subject.touch_out(exit)
    expect(subject).to respond_to(:history)
  end
  # it "stores journeys in history" do
  #   subject.top_up(15)
  #   subject.touch_in(entry)
  #   subject.touch_out(exit)
  #   expect(subject.history).to eq([{ :entry => entry, :exit => exit }])
  # end
end
