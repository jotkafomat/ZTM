describe 'User Stories' do
 let(:oystercard) { Oystercard.new }
 let(:station) { Station.new }

  it 'oystercard has balance equal 0 on initalization' do
    expect(oystercard.balance).to equal 0
  end
  it 'user can add money to a card' do

    expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
  end

  it'raises an error when balance is higher then 90' do

    expect { oystercard.top_up(91) }.to raise_error 'Cannot top up £91. the maximum balance is £90'
  end

  describe '#touch_in' do

    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end

    it'change in in_journey status when touch in' do
      oystercard.top_up(5)
      oystercard.touch_in(station)

      expect(oystercard).to be_in_journey
    end

    it'remembers entry station when touch in' do

      oystercard.top_up(5)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end
  describe '#touch_out' do

    it'change in in_journey status when touch out' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      oystercard.touch_out

      expect(oystercard).not_to be_in_journey
    end

    it'deduct minimum fare on touch out' do
      oystercard.top_up(5)
      oystercard.touch_in(station)

      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it'forgets entry station when touch out' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end

  describe 'minimum balnce' do
    it'checks if there is 1£ on the card' do
      expect { oystercard.touch_in(station) }.to raise_error 'Insufficient funds, Please toup your card'
    end
  end
end
