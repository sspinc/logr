require 'spec_helper'

describe Logr::Metric do
  let(:value) { 123.4 }
  let (:metric) { Logr::Metric.new('test_metric', value, 'counter') }

  describe '#to_hash' do
    it 'should include name in hash' do
      expect(metric.to_hash[:name]).to eq('test_metric')
    end

    it 'should include value in hash' do
      expect(metric.to_hash[:value]).to eq(value)
    end

    it 'should include type in hash' do
      expect(metric.to_hash[:type]).to eq('counter')
    end
  end
end
