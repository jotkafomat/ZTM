describe 'User Stories' do
 let(:oystercard) { Oystercard.new }
 let(:station) { Station.new(name: "Brixton", zone: 2) }
 let(:station2) { Station.new(name: "Pimlico", zone: 1)}


 describe 'initalization - user stories1' do
    it 'oystercard has balance equal 0 on initalization' do
      expect(oystercard.balance).to equal 0
    end

    it 'has empty travel history upon init' do
      expect(oystercard.travel_history).to be_empty
    end
  end

  describe 'user stories2 - user can add money to card' do
    it 'user can add money to a card' do

      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end
  end

  describe "user stories3 - I don't want to put too much money on my card" do
    it'raises an error when balance is higher then 90' do

      expect { oystercard.top_up(91) }.to raise_error 'Cannot top up £91. the maximum balance is £90'
    end
  end

  describe 'user stories 4 -I need my fare deducted from my card' do
    it'deduct minimum fare on touch out' do
      oystercard.top_up(5)
      oystercard.touch_in(station)

      expect { oystercard.touch_out(station2) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  describe 'user stories 5 I need to touch in and out' do
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
        oystercard.touch_out(station2)

        expect(oystercard).not_to be_in_journey
      end

      it'forgets entry station when touch out' do
        oystercard.top_up(5)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect(oystercard.entry_station).to eq nil
      end
    end
  end


  describe 'user stories 6 I need to have the minimum amount for a single journey' do
    describe 'minimum balnce' do
      it'checks if there is 1£ on the card' do
        expect { oystercard.touch_in(station) }.to raise_error 'Insufficient funds, Please toup your card'
      end
    end
  end
  describe 'user stories 7 I need to know where Ive travelled from' do

    describe 'travel_history' do
      it 'user can check from where is comming from' do
        oystercard.top_up(5)
        oystercard.touch_in(station)
        oystercard.touch_out(station2)
        expect(oystercard.travel_history.last[:entry_station]).to eq station
      end
    end
  end

  describe ' user stories 8 - I want to see to all my previous trips' do

    it 'adds one journey' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      journey = {entry_station: station, exit_station: station2}

      expect(oystercard.travel_history.last).to eq journey
    end
  end
  describe ' user stories 9 I want to know what zone a station is in' do
    it'user can check what exit station zone is' do
      oystercard.top_up(5)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      expect(oystercard.travel_history.last[:exit_station].zone).to eq 1
    end
  end

end
