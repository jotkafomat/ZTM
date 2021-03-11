require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station}
  let(:station2) {double :station}

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
      oystercard.touch_in(station)

      expect(oystercard.in_journey?).to eq true
    end

    it'remembers entry station when touch in' do

      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end

    describe '#touch_out'do
      it'change in in_journey status when touch out' do
        oystercard.top_up(5)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)

        expect(oystercard.in_journey?).to eq false
      end

      it'deduct minimum fare on touch out' do
        oystercard.top_up(5)
        oystercard.touch_in(station)

        expect { oystercard.touch_out(station2) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
      end
      it 'forgets entry station when touch out' do
        oystercard.top_up(5)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect(oystercard.entry_station).to eq nil
      end
    end

    describe 'minimum balnce' do
      it'checks if there is 1£ on the card' do
        expect { oystercard.touch_in(station) }.to raise_error 'Insufficient funds, Please toup your card'
      end
    end

    describe '#travel_history' do
      it 'is empty upon creation'do
        expect(oystercard.travel_history).to be_empty
      end
      it 'adds one journey' do
        oystercard.top_up(5)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect(oystercard.travel_history).not_to be_empty
      end
    end
end
