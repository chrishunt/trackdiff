require 'spec_helper.rb'

describe Net::HTTP do
  describe '#get_response' do
    it 'should return a mock response' do
      Net::HTTP.get_response('http://google.com').class.should == Mock::Response
    end
  end
end

describe Mock::Response do
  describe '#body' do
    it 'should return the same mock response object' do
      response = Net::HTTP.get_response(URI.parse('http://google.com'))
      response.body.should == response
    end
  end

  describe '#sum' do
    it 'should return unique int for each url' do
      urls = ['http://google.com', 'http://yahoo.com', 'http://msn.com']
      results = []
      urls.each do |url|
        sum = Net::HTTP.get_response(URI.parse(url)).body.sum
        results.include?(sum).should_not == true
        results << sum
      end
    end
  end
end
