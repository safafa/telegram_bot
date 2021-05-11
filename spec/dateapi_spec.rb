require_relative '../lib/dateapi'

describe DateApi do
  let(:dateapi) { DateApi.new('06', '01') }
  describe '.initialize' do
    it 'instantiate dateapi class' do
      expect(dateapi).to be_instance_of(DateApi)
    end
    it 'initialize  a the day  variable ' do
      expect(dateapi.day).to eq '01'
    end
    it 'initialize  a the month variable ' do
      expect(dateapi.month).to eq '06'
    end
    it 'Throw error when no argument is given' do
      expect { DateApi.new }.to raise_error
    end
  end

  describe '#message' do
    it 'return a Hash object' do
      stub_request(:get, 'https://numbersapi.p.rapidapi.com/06/01/date?fragment=true&json=true')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'numbersapi.p.rapidapi.com',
            'User-Agent' => 'Ruby',
            'X-Rapidapi-Host' => 'numbersapi.p.rapidapi.com',
            'X-Rapidapi-Key' => '5ab8b06151msh2a2292ff926d71cp1cf742jsn4ef5742bf2ab'
          }
        )
        .to_return(status: 200, body: '{"text": "the Royal Ulster Constabulary is founded","year": 1922}', headers: {})
      expect(dateapi.message).to be_instance_of(Hash)
    end
    it 'return Ressource not found when eror 404', authorized: true do
      stub_request(:get, 'https://numbersapi.p.rapidapi.com/06/01/date?fragment=true&json=true')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'numbersapi.p.rapidapi.com',
            'User-Agent' => 'Ruby',
            'X-Rapidapi-Host' => 'numbersapi.p.rapidapi.com',
            'X-Rapidapi-Key' => '5ab8b06151msh2a2292ff926d71cp1cf742jsn4ef5742bf2ab'
          }
        )
        .to_timeout
      expect { dateapi.message }.to raise_error
    end
  end
end
