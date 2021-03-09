require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#init' do
    it { is_expected.to respond_to :balance }

    it 'oystercard start with inital balance = 0' do
      expect(oystercard.balance).to eq 0
    end
  end
end
