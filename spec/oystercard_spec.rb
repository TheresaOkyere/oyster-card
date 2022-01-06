require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :station }
  let(:exit_station) { double :station }

  it 'balance starts with zero' do
    expect(subject.balance).to eq 0
  end

 it 'allow user to add balance' do
   oyster = Oystercard.new
   expect(oyster).to respond_to(:top_up).with(1).argument
end

it 'updates the balance' do
  oyster = Oystercard.new
  expect(oyster.top_up(5)).to eq 5
end

it 'has a balance limit' do
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  subject.top_up(maximum_balance)
  expect{ subject.top_up 1 }.to raise_error 'You have reached your balance limit'
end


describe '#in_journey' do
it { is_expected.to respond_to(:in_journey?) }

it 'checks if user had touch in' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  expect(subject.in_journey?).to eq true
end

it 'checks if user had touch out' do
  expect(subject.in_journey?).to eq false
end
end


describe '#touch_in' do
it {is_expected.to respond_to(:touch_in!)}

it 'allows user to touch in' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  expect(subject).to be_in_journey
end

it 'will not touch in if below minimum balance' do
  expect{subject.touch_in!(entry_station) }.to raise_error 'not enough money'
end

it ' allows the user to remember entry station ' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  expect(subject.entry_station).to eq entry_station
end

describe '#touch_out' do
it {is_expected.to respond_to(:touch_out!)}

it 'allows the user to touch out' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  subject.touch_out!(exit_station)
  #expect(subject).not_to be_in_journey
expect{ subject.touch_out!(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
end

it 'stores exit station' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  subject.touch_out!(exit_station)
  expect(subject.exit_station).to eq exit_station
end

describe '#journeys' do
it 'has an empty list of journeys by default' do
  expect(subject.journeys).to be_empty
end

it 'stores a journey' do
  subject.top_up(5)
  subject.touch_in!(entry_station)
  subject.touch_out!(exit_station)
  expect(subject.journeys).to include @journeys
end
end
end
end
end
