require 'spec_helper'

describe Logr::Event do
  let (:event) { Logr::Event.new('test_event', context_1_key: 'context_1_value', context_2_key: 'context_2_value') }

  describe '#to_hash' do
    it 'should include name in hash' do
      expect(event.to_hash[:name]).to eq('test_event')
    end

    it 'should include context in hash' do
      hash = event.to_hash
      expected_hash = {
        context_1_key: 'context_1_value',
        context_2_key: 'context_2_value'
      }
      expect(hash).to include(expected_hash)
    end
  end

  describe '#with' do
    let(:event_with) { event.with(context_3_key: 'context_3_value') }

    it 'should keep the name of the event' do
      expect(event_with.name).to eq('test_event')
    end

    it 'should merge contexts' do
      expect(event_with.context).to include(context_3_key: 'context_3_value')
    end

  end
end
