require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#init' do

    it 'oystercard start with inital balance = 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'allows to top_up card' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it 'increases the card balance when top_up'do

      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it'raises an error when balance is higher then 90' do
      expect { oystercard.top_up(91) }.to raise_error "Cannot top up £91. the maximum balance is £#{Oystercard::MAXIMUM_BALANCE}"
    end

    it'deducts fare from oystercard' do
      oystercard.top_up(10)

      expect { oystercard.deduct(3) }.to change { oystercard.balance }.by(-3)
    end
  end
end
