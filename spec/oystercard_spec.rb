require './lib/oystercard.rb'


  describe OysterCard do
    let(:station){ double :station }
    let(:card){described_class.new}
    let(:journey){Journey.new}

    describe '#initialize' do
      it 'tests that new cards have a balance of 0' do
        expect(card.balance).to eq 0
      end
      it 'tests that default journey_start equals nil' do
        expect(card.journey_start).to eq nil
      end
      it 'tests that default journey history is an empty array' do
        expect(card.journey_history).to be_empty
      end
    #  it 'tests that default journeys hash is empty' do
    #    expect(card.journeys).to be_empty
    #  end
    end

    describe '#in_journey' do
      it 'returns true if user is in_journey' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        expect(card.journey.in_journey).to be(true)
      end
      it 'returns false if not in_journey' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.journey.in_journey).to be(false)
      end
    end

    describe '#top_up' do
      it 'accepts a number as an argument and increases balance by that much' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        expect{card.top_up(amount)}.to change{card.balance}.by(amount)
      end
      it 'limits balance to a maximum of £90' do
        amount = (OysterCard::MAXIMUMBALANCE)+1
        expect{card.top_up(amount)}.to raise_error "The maximum balance has already been reached"
      end
    end

    describe '#deduct' do
      it 'deducts amount from balance' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        expect{card.send(:deduct, amount)}.to change{card.balance}.by(-amount)
      end
    end

    describe '#touch_in' do
      it 'checks balance and if enough money, updates in_journey to true' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        expect(card.journey.in_journey).to be(true)
      end
      it 'checks balance and raises error if insufficient funds' do
        expect{card.touch_in(station)}.to raise_error("Insufficient funds")
      end
      it 'pushes start station to journey_history' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        expect{card.touch_in(station)}.to change{card.journey_history.count}.by(1)
      end
    end

    describe '#touch_out' do
      it 'when user touches out it updates in_journey to false' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.journey.in_journey).to be(false)
      end
      it 'reduces balance by minimum fare' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        expect{card.touch_out(station)}.to change{card.balance}.by(-OysterCard:: MINIMUMFAIR)
      end
      it 'pushes exit station to journey_history' do
        amount = ((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.top_up(amount)
        card.touch_in(station)
        expect{card.touch_out(station)}.to change{card.journey_history.count}.by(1)
      end
    end

    describe '#journey_start' do
      it 'logs the station where the user touched in' do
        card.top_up((OysterCard::MAXIMUMBALANCE)-(card.balance))
        card.touch_in(station)
        expect(card.journey_start).to eq(station)
      end
    end
  end
