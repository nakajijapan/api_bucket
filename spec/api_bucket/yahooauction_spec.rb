# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/amazon')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/rakuten')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/api_bucket/yahooauction')
require File.expand_path(File.dirname(__FILE__) + '/../../spec/secret')

describe "ApiBucket::Yahooauction" do

  context '#search_item' do
    it 'response is ApiBucket::Yahooauction::Response' do
      service = ApiBucket::Yahooauction::Client.new
      service.search('ruby').class.should == ApiBucket::Yahooauction::Response
    end

    it 'item in response is ApiBucket::Yahooauction::Item' do
      service = ApiBucket::Yahooauction::Client.new
      service.search('ruby').items[0].class.should == ApiBucket::Yahooauction::Item
    end

    it 'can search items' do
      service = ApiBucket::Yahooauction::Client.new
      response = service.search(Keywords: 'ruby')
      response.items.should have_at_least(2).items
    end

    it 'is invalid setting' do
      service = ApiBucket::Yahooauction::Client.new
      service.search(nil).items.should be_empty
    end
  end

  context '#lookup' do
    before(:all) do
      sleep 3
      service = ApiBucket::Yahooauction::Client.new
      @response = service.lookup('l170668533')
    end

    it 'can lookup item' do
      @response.items.should have_at_most(1).items
    end

    it 'can get product_code' do
      @response.items.first.product_code.should match(/[a-zA-Z1-9:]+/)
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

    it 'is invalid setting' do
      sleep 3
      service = ApiBucket::Yahooauction::Client.new
      service.lookup(nil).items.first.should be_nil
    end
  end
end
