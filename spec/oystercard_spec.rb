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
end
