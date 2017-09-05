require './lib/oystercard.rb'
require './lib/station.rb'

  describe OysterCard do
    it 'tests that new cards have a balance of 0' do
      card = OysterCard.new
      expect(card.balance).to eq 0
    end
    it 'tests that default journey_start equals nil' do
      card = OysterCard.new
      expect(card.journey_start).to eq nil
    end
    it 'tests that default journey history is an empty array' do
      card = OysterCard.new
      expect(card.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'accepts a number as an argument and increases balance by that much' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      expect{card.top_up(amount)}.to change{card.balance}.by(amount)
    end
    it 'limits balance to a maximum of £90' do
      card = OysterCard.new
      amount = (OysterCard::MAXIMUMBALANCE)+1
      expect{card.top_up(amount)}.to raise_error "The maximum balance has already been reached"
    end
  end

  describe '#deduct' do
    it 'deducts amount from balance' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.top_up(amount)
      expect{card.send(:deduct, amount)}.to change{card.balance}.by(-amount)
    end
  end

  describe '#touch_in' do
    let(:station){ double :station }
    it 'checks balance and if enough money,updates in_journey to true' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.top_up(amount)
      card.touch_in(station)
      expect(card.in_journey?).to be(true)
    end
    it 'checks balance and updates in_journey to false if less than £1 on card' do
      card = OysterCard.new
      expect{card.touch_in(station)}.to raise_error("Insufficient funds")
    end
    it 'pushes start station to journey_history' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.top_up(amount)
      expect{card.touch_in(station)}.to change{card.journey_history.count}.by(1)
    end
  end

  describe '#in_journey' do
    let(:station){ double :station }
    it 'returns true if in_journey' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.top_up(amount)
      card.touch_in(station)
      expect(card.in_journey?).to be(true)
    end
    it 'returns false if not in_journey' do
      card = OysterCard.new
      expect(card.in_journey?).to be(false)
    end
  end

  describe '#touch_out' do
    let(:station){ double :station }
    it 'updates in_journey to false' do
      card = OysterCard.new
      card.touch_out
      expect(card.in_journey?).to be(false)
    end
    it 'reduces balance by minimum fare' do
      card = OysterCard.new
      amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.top_up(amount)
      card.touch_in(station)
      expect{card.touch_out}.to change{card.balance}.by(-OysterCard:: MINIMUMFAIR)
    end
  end

  describe '#journey_start' do
    let(:station){ double :station }
    it 'logs the station where the user touched in' do
      card = OysterCard.new
      card.top_up((OysterCard::MAXIMUMBALANCE)-(card.balance))
      card.touch_in(station)
      expect(card.journey_start).to eq(station)
    end
  end
