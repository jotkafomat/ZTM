require 'station'
describe Station do

  subject(:oystercard) { described_class.new(name: "Brixton", zone: 2) }

  it 'knows its name' do
    expect(subject.name).to eq("Brixton")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(2)
  end
end
