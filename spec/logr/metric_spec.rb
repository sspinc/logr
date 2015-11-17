require 'spec_helper'

describe Logr::Metric do
  context 'numeric value' do
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

  context 'non-numeric value' do
    describe '#new' do
      it 'should fail' do
        expect{ Logr::Metric.new('test_metric', 'value', 'counter') }.to raise_error(TypeError, "Metric must be a numeric value")
      end
    end

  end
end
