# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/amazon')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/rakuten')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/yahooauction')
require File.expand_path(File.dirname(__FILE__) + '/../../spec/secret')

describe "ApiBucket::Rakuten" do

  describe '#search_item' do
    it 'response is ApiBucket::Rakuten::Response' do
      service = ApiBucket::Rakuten::Client.new
      expect(service.search('ruby').class).to eq ApiBucket::Rakuten::Response
    end

    it 'item in response is ApiBucket::Rakuten::Item' do
      service = ApiBucket::Rakuten::Client.new
      expect(service.search('ruby').items[0].class).to eq ApiBucket::Rakuten::Item
    end

    it 'can search items' do
      service = ApiBucket::Rakuten::Client.new
      response = service.search('ruby')
      expect(response.items.count).to be > 2
    end

    it 'is invalid setting' do
      service = ApiBucket::Rakuten::Client.new
      expect(service.search(nil).items).to be_empty
    end
  end

  describe '#lookup' do
    before(:all) do
      sleep 3
      service = ApiBucket::Rakuten::Client.new
      @response = service.lookup('book:15917863')
    end

    it 'is invalid setting' do
      service = ApiBucket::Rakuten::Client.new
      expect(service.lookup(nil).items.first).to be_nil
    end
    it 'can lookup item' do
      expect(@response.items.count).to eq 1
    end

    it 'can get product_code' do
      expect(@response.items.first.product_code).to match(/[a-zA-Z1-9:]+/)
    end

    it 'can get detail_url' do
      expect(@response.items.first.detail_url).to match(/[a-zA-Z1-9:\/]+/)
    end

    it 'can get images' do
      expect(@response.items.first.image.count).to be > 2
    end

    it 'can get image' do
      expect(@response.items.first.image[:l][:url]).to match(/[a-zA-Z1-9:\/]+/)
    end
  end
end
