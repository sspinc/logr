require 'spec_helper'

describe Logr::Event do
  let (:event) { Logr::Event.new('test_event', tags_1_key: 'tags_1_value', tags_2_key: 'tags_2_value') }

  describe '#to_hash' do
    it 'should include name in hash' do
      expect(event.to_hash[:name]).to eq('test_event')
    end

    it 'should include tags in hash' do
      hash = event.to_hash
      expected_hash = {
        tags_1_key: 'tags_1_value',
        tags_2_key: 'tags_2_value'
      }
      expect(hash).to include(expected_hash)
    end
  end

  describe '#with' do
    let(:event_with) { event.with(tags_3_key: 'tags_3_value') }

    it 'should keep the name of the event' do
      expect(event_with.name).to eq('test_event')
    end

    it 'should merge tags' do
      expect(event_with.tags).to include(tags_3_key: 'tags_3_value')
    end

  end
end
