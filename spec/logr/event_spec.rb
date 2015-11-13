require 'spec_helper'

describe Logr::Event do
  let (:event) { Logr::Event.new('test_event', context_1_key: 'context_1_value', context_2_key: 'context_2_value') }

  describe '#to_hash' do
    it 'should output a hash that has the event name' do
      expect(event.to_hash[:name]).to eq('test_event')
    end

    it 'should merge contexts into hash' do
      hash = event.to_hash
      hash.delete(:name)
      expected_hash = {
        context_1_key: 'context_1_value',
        context_2_key: 'context_2_value'
      }
      expect(hash).to eq(expected_hash)
    end
  end

  describe '#with' do
    before do
      event = event.with(context_3_key: 'context_3_value')
    end

    it 'should output a hash that has the event name' do
      expect(event.to_hash[:name]).to eq('test_event')
    end

    it 'should merge contexts into hash' do
      hash = event.to_hash
      hash.delete(:name)
      expected_hash = {
        context_1_key: 'context_1_value',
        context_2_key: 'context_2_value',
        context_3_key: 'context_3_value'
      }
      expect(hash).to eq(expected_hash)
    end

  end
end
