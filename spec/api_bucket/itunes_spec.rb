# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/itunes')

describe "ApiBucket::Itunes" do

  describe '#search_item' do
    it 'response is ApiBucket::Itunes::Response' do
      service = ApiBucket::Itunes::Client.new
      expect(service.search('ruby').class).to eq ApiBucket::Itunes::Response
    end

    it 'item in response is ApiBucket::Itunes::Item' do
      service = ApiBucket::Itunes::Client.new
      service.search('ruby').items[0].class.should == ApiBucket::Itunes::Item
    end

    it 'can search items' do
      service = ApiBucket::Itunes::Client.new
      response = service.search(Keywords: 'ruby')
      response.items.should have_at_least(2).items
    end

    it 'is invalid setting' do
      service = ApiBucket::Itunes::Client.new
      service.search(nil).items.should be_empty
    end
  end

  describe '#lookup' do
    before(:all) do
      service = ApiBucket::Itunes::Client.new
      @response = service.lookup('332209930', {})
    end

    it 'is invalid setting' do
      service = ApiBucket::Itunes::Client.new
      service.lookup(nil, {}).items.first.should be_nil
    end

    it 'can lookup item' do
      @response.items.should have_at_most(1).items
    end

    it 'can get product_code' do
      @response.items.first.product_code.should match(/[a-zA-Z1-9]+/)
    end

    it 'can get detail_url' do
      @response.items.first.detail_url.should match(/[a-zA-Z1-9:\/]+/)
    end

    it 'can get images' do
      @response.items.first.image.should have(3).items
    end

    it 'can get image' do
      @response.items.first.image[:l][:url].should match(/[a-zA-Z1-9:\/]+/)
    end

  end
end
