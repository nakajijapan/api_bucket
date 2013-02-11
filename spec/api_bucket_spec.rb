require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require File.expand_path(File.dirname(__FILE__) + '/../lib/api_bucket')
require File.expand_path(File.dirname(__FILE__) + '/../lib/api_bucket/amazon')
require File.expand_path(File.dirname(__FILE__) + '/../lib/api_bucket/rakuten')
require File.expand_path(File.dirname(__FILE__) + '/../lib/api_bucket/yahooauction')
require File.expand_path(File.dirname(__FILE__) + '/../lib/api_bucket/itunes')

describe "ApiBucket" do

  context 'when we select Amazon ECS' do
    describe 'ApiBucket::Service' do
      it 'can get instance' do
        ApiBucket::Service::instance(:amazon).should be_a_kind_of(ApiBucket::Amazon::Base)
      end

      it 'can get service code(string)' do
        ApiBucket::Service::code('amazon').should == ApiBucket::Service::SERVICE_AMAZON
      end

      it 'can get service code(symbol)' do
        ApiBucket::Service::code(:amazon).should == ApiBucket::Service::SERVICE_AMAZON
      end

      it 'can get service name' do
        ApiBucket::Service::name(ApiBucket::Service::SERVICE_AMAZON).should == :amazon
      end
    end
  end

  context 'when we select iTunes' do
    describe 'ApiBucket::Service' do
      it 'can get instance' do
        ApiBucket::Service::instance(:itunes).should be_a_kind_of(ApiBucket::Itunes::Base)
      end

      it 'can get service code(string)' do
        ApiBucket::Service::code('itunes').should == ApiBucket::Service::SERVICE_ITUNES
      end

      it 'can get service code(symbol)' do
        ApiBucket::Service::code(:itunes).should == ApiBucket::Service::SERVICE_ITUNES
      end

      it 'can get service name' do
        ApiBucket::Service::name(ApiBucket::Service::SERVICE_ITUNES).should == :itunes
      end
    end
  end

  context 'when we select Rakuten' do
    describe 'ApiBucket::Service' do
      it 'can get instance' do
        ApiBucket::Service::instance(:rakuten).should be_a_kind_of(ApiBucket::Rakuten::Base)
      end

      it 'can get service code(string)' do
        ApiBucket::Service::code('rakuten').should == ApiBucket::Service::SERVICE_RAKUTEN
      end

      it 'can get service code(symbol)' do
        ApiBucket::Service::code(:rakuten).should == ApiBucket::Service::SERVICE_RAKUTEN
      end

      it 'can get service name' do
        ApiBucket::Service::name(ApiBucket::Service::SERVICE_RAKUTEN).should == :rakuten
      end
    end
  end

  context 'when we select Yahooauction' do
    describe 'ApiBucket::Service' do
      it 'can get instance' do
        ApiBucket::Service::instance(:yahooauction).should be_a_kind_of(ApiBucket::Yahooauction::Base)
      end

      it 'can get service code(string)' do
        ApiBucket::Service::code('yahooauction').should == ApiBucket::Service::SERVICE_YAHOOAUCTION
      end

      it 'can get service code(symbol)' do
        ApiBucket::Service::code(:yahooauction).should == ApiBucket::Service::SERVICE_YAHOOAUCTION
      end

      it 'can get service name' do
        ApiBucket::Service::name(ApiBucket::Service::SERVICE_YAHOOAUCTION).should == :yahooauction
      end
    end
  end
end
