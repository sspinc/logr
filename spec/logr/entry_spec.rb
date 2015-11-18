require 'spec_helper'

describe Logr::Entry do
  let(:logger) { double('logger') }
  let(:entry) { Logr::Entry.new(logger) }
  let(:message) { 'test message' }

  describe '#event' do
    let(:entry_event) { entry.event('test_event', tags_1_key: 'tags_1_value') }

    it 'should add the event with the correct name' do
      expect(entry_event.event.name).to eq('test_event')
    end

    it 'should add the event with the correct tags' do
      expect(entry_event.event.tags).to include(tags_1_key: 'tags_1_value')
    end
  end

  describe '#with' do
    context 'existing event' do
      let(:entry_event) { entry.event('test_event', tags_1_key: 'tags_1_value') }
      let(:entry_event_with) { entry_event.with(tags_2_key: 'tags_2_value') }

      it 'should keep the event name' do
        expect(entry_event_with.event.name).to eq('test_event')
      end

      it 'should keep the old event tags' do
        expect(entry_event_with.event.tags).to include(tags_1_key: 'tags_1_value')
      end

      it 'should add the new event tags' do
        expect(entry_event_with.event.tags).to include(tags_2_key: 'tags_2_value')
      end
    end

    context 'non-existing event' do
      it 'should fail' do
        expect { entry.with }.to raise_error(RuntimeError, 'No event to append to. Please call #event first.')
      end
    end
  end

  describe '#metric' do
    let(:entry_metric_1) { entry.metric('test_metric_1', 1.111) }
    let(:entry_metric_2) { entry_metric_1.metric('test_metric_2', 2, type: 'gauge') }

    it 'should keep existing metric' do
      expect(entry_metric_2.metrics).to include(entry_metric_1.metrics[0])
    end

    it 'should add a new metric with the correct name' do
      expect(entry_metric_2.metrics[1].name).to eq('test_metric_2')
    end

    it 'should add a new metric with the correct value' do
      expect(entry_metric_2.metrics[1].value).to eq(2)
    end

    it 'should add a new metric with the correct type' do
      expect(entry_metric_2.metrics[1].type).to eq('gauge')
    end
  end

  describe '#monitored' do
    context 'existing event' do
      let(:entry_event) { entry.event('test_event', tags_1_key: 'tags_1_value') }
      let(:entry_event_monitored) { entry_event.monitored('title', 'text') }

      it 'should keep the event name' do
        expect(entry_event_monitored.event.name).to eq(entry_event.event.name)
      end

      it 'should keep the original event tags' do
        expect(entry_event_monitored.event.tags).to include(entry_event.event.tags)
      end

      it 'should add title and text to event tags' do
        expect(entry_event_monitored.event.tags).to include(monitored: true, title: 'title', text: 'text')
      end
    end

    context 'non-existing event' do
      it 'should fail' do
        expect { entry.monitored('title', 'text') }.to raise_error(RuntimeError, 'No event to monitor. Please call #event first.')
      end
    end
  end

  RSpec::Matchers.define :have_message do |expected|
    match do |actual|
      actual.message == expected
    end
  end

  %w[debug info warn error fatal].each do |level|
    describe "##{level}" do
      it "should call logger.#{level} with Entry object" do
        expect(logger).to receive(level).with(instance_of(Logr::Entry))
        entry.send(level)
      end

      it "should call logger.#{level} with the supplied message" do
        expect(logger).to receive(level).with(have_message(message))
        entry.send(level, message)
      end
    end
  end
 end
