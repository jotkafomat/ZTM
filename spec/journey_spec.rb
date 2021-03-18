require 'journey'

describe Journey do
  subject(:journey){described_class.new(entry_station: :station)}

  it 'is created with an entry station' do
    expect(journey.entry_station).to eq :station
  end

  it "knows if a journey is not complete" do
    expect(journey).not_to be_complete
  end

  describe '#fare' do
    let(:station) { double :station, name: "Brixton", zone: 2}
    let(:station2) { double :station, name: "Pimlico", zone: 1}

    it 'has a penalty fare by default' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "returns itself when exiting a journey" do
      expect(journey.exit(station)).to eq(subject)
    end

    context 'given an entry station' do
      subject(:journey) { described_class.new(entry_station: station) }

      it 'has an entry station' do
        expect(journey.entry_station).to eq station
      end

      it "returns a penalty fare if no exit station given" do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end

      it "completes journey if exit with no station given" do
        journey.exit
        expect(journey).to be_complete
      end
    end

    context 'given an exit station' do
      before do
        journey.exit(station2)
      end

      it 'has an exit station' do
        expect(journey.exit_station).to eq station2
      end

      it "knows if a journey is complete" do
        expect(journey).to be_complete
      end

      it "returns a minimum fare if exit station given" do
        expect(journey.fare).to eq Journey::MINIMUM_FARE
      end
    end
  end
end
