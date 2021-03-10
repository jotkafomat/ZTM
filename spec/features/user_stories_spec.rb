describe 'User Stories' do
 let(:oystercard) { Oystercard.new }

   # In order to use public transport
   # As a customer
   # I want money on my card
  it 'oystercard has balance equal 0 on initalization' do
    expect(oystercard.balance).to equal 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card
  it 'user can add money to a card' do

    expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
  end

  it'raises an error when balance is higher then 90' do

    expect { oystercard.top_up(91) }.to raise_error 'Cannot top up £91. the maximum balance is £90'
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.
  describe '#touch_in' do

    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end

    it'change in in_journey status when touch in' do
      oystercard.top_up(5)
      oystercard.touch_in

      expect(oystercard).to be_in_journey
    end

  end
  describe '#touch_out' do

    it'change in in_journey status when touch out' do
      oystercard.top_up(5)
      oystercard.touch_in
      oystercard.touch_out

      expect(oystercard).not_to be_in_journey
    end

    it'deduct minimum fare on touch out' do
      oystercard.top_up(5)
      oystercard.touch_in

      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  describe 'minimum balnce' do
    it'checks if there is 1£ on the card' do
      expect { oystercard.touch_in }.to raise_error 'Insufficient funds, Please toup your card'
    end
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card



end
