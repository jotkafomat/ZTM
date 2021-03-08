require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#init' do
    it { is_expected.to respond_to :balance }
  end
end
