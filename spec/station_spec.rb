require './lib/station.rb'

describe Station do
  let(:station_zone){double :station_zone}
  let(:station_name){double :station_name}
  let(:station){described_class.new(station_name, station_zone)}

  describe '#initialize' do
    it 'returns name of station where user touched in' do
      expect(station.name).to eq(station_name)
    end
    it 'returns zone of station where user touched in' do
      expect(station.zone).to eq(station_zone)
    end
  end
end
