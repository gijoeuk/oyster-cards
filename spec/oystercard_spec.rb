require './lib/oystercard.rb'

describe OysterCard do
  it 'tests that new cards have a balance of 0' do
    card = OysterCard.new
    expect(card.balance).to eq 0
  end

  it 'accepts a number as an argument and increases balance by that much' do
    # Arrange
    card = OysterCard.new
    amount = 10
    # Action
    # Assert
    expect(card.top_up(amount)).to eq (card.balance)
  end

  it 'limits balance to a maximum of £90' do
    # Arrange
    card = OysterCard.new
    amount = 91
    # Action
    # Assert
    expect{card.top_up(amount)}.to raise_error "The maximum balance has already been reached"
  end

describe '#deduct' do
  it 'deducts amount from balance' do
    #Arrange
    card = OysterCard.new
    amount = 4
    # Action
    card.top_up(10)
    # Assert

    expect(card.deduct(amount)).to eq (card.balance)
  end
end

describe '#touch_in' do
  it 'checks balance and if enough money,updates in_journey to true' do
      card = OysterCard.new
      card.top_up(5)
      card.touch_in
      expect(card.in_journey).to eq true
    end
    it 'checks balance and updates in_journey to false if less than £1 on card' do
      card = OysterCard.new
      expect{card.touch_in}.to raise_error("Insufficient funds")
    end
  end

  describe '#touch_out' do
    it 'updates in_journey to false' do
      card = OysterCard.new
      card.touch_out
      expect(card.in_journey).to eq false
    end
  end
end
