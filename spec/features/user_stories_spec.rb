describe 'User Stories' do
 let(:oystercard) { Oystercard.new }

  describe '#initalization' do

   it 'oystercard has balance equal 0 on initalization' do
     expect(oystercard.balance).to equal 0
   end
  end
# In order to keep using public transport
# As a customer
# I want to add money to my card

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

  describe '#top up' do
    it 'user can add money to a card' do
  expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it'raises an error when balance is higher then 90' do
      expect { oystercard.top_up(91) }.to raise_error 'Cannot top up £91. the maximum balance is £90'
    end
  end

end
