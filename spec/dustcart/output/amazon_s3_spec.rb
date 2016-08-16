require 'spec_helper'
require 'dustcart/output/base'
require 'dustcart/output/amazon_s3'

describe Dustcart::Resource::Output::AmazonS3 do
  describe '#initilize' do
    subject(:s3) { Dustcart::Resource::Output::AmazonS3.new(from, mode, &block) }

    context 'from parameter given' do
      let(:from) { '/test/base_dir/20160101123456' }
      let(:mode) { :all }
      let(:block) { nil }
    end
  end
end
