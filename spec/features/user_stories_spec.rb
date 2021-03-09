describe 'User Stories' do
 let(:oystercard) { Oystercard.new }

  describe '#initalization' do

   it 'oystercard has balance equal 0 on initalization' do
     expect(oystercard.balance).to equal 0
   end
  end
end
