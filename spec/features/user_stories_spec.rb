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

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it'deducts fare from ouystercard' do
    oystercard.top_up(10)

    expect { oystercard.deduct(3) }.to change { oystercard.balance }.by(-3)
  end
end
