require 'journey'
describe 'Journey' do
  let(:journey){Journey.new(station)}
  let(:station){ double :station }
  describe '#initialize' do
    it 'checks that in journey is true on initialisation' do
        expect(journey.in_journey).to be(true)
    end
    it 'logs journey_start station upon creation' do
      expect(journey.journey_start).to eq(station)
    end
  end

  describe '#touch_out' do
    it 'updates in_journey to false when called' do
      expect{journey.touch_out}.to change{journey.in_journey}.to(false)
    end
  end
end
