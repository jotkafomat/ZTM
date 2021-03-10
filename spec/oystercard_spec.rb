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
  end

    describe '#touch_in' do
      it'change in in_journey status when touch in' do
        oystercard.top_up(5)
        oystercard.touch_in

        expect(oystercard.in_journey?).to eq true
      end
    end

    describe '#touch_out'do
      it'change in in_journey status when touch out' do
        oystercard.top_up(5)
        oystercard.touch_in
        oystercard.touch_out

        expect(oystercard.in_journey?).to eq false
      end

      it'deduct minimum fare on touch out' do
        oystercard.top_up(5)
        oystercard.touch_in

        expect { oystercard.touch_out }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end

    describe 'minimum balnce' do
      it'checks if there is 1£ on the card' do
        expect { oystercard.touch_in }.to raise_error 'Insufficient funds, Please toup your card'
      end
    end
end
