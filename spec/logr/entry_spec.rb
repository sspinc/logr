require 'spec_helper'

describe Logr::Entry do
  let(:logger) { double('logger') }
  let(:entry) { Logr::Entry.new(logger) }

  describe '#event' do
    let(:entry_event) { entry.event('test_event', context_1_key: 'context_1_value') }

    it 'should add the event with the correct name' do
      expect(entry_event.event.name).to eq('test_event')
    end

    it 'should add the event with the correct context' do
      expect(entry_event.event.context).to include(context_1_key: 'context_1_value')
    end
  end

  describe '#with' do
    context 'existing event' do
      let(:entry_event) { entry.event('test_event', context_1_key: 'context_1_value') }
      let(:entry_event_with) { entry_event.with(context_2_key: 'context_2_value') }

      it 'should keep the event name' do
        expect(entry_event_with.event.name).to eq('test_event')
      end

      it 'should keep the old event context' do
        expect(entry_event_with.event.context).to include(context_1_key: 'context_1_value')
      end

      it 'should add the new event context' do
        expect(entry_event_with.event.context).to include(context_2_key: 'context_2_value')
      end
    end

    context 'non-existing event' do
      it 'should fail' do
        expect { entry.with }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#metric' do
    let(:entry_metric_1) { entry.metric('test_metric_1', 'one') }
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
    let(:entry_event) { entry.event('test_event', context_1_key: 'context_1_value') }
    let(:entry_event_monitored) { entry_event.monitored('title', 'text') }

    it 'should keep the event name' do
      expect(entry_event_monitored.event.name).to eq(entry_event.event.name)
    end

    it 'should keep the original event context' do
      expect(entry_event_monitored.event.context).to include(entry_event.event.context)
    end

    it 'should add title and text to event context' do
      expect(entry_event_monitored.event.context).to include(monitored: true, title: 'title', text: 'text')
    end
  end

  describe '#debug' do
    it 'should call logger.debug with Entry object' do
      expect(logger).to receive(:debug).with(instance_of(Logr::Entry))
      entry.debug
    end
  end

  describe '#info' do
    it 'should call logger.info with Entry object' do
      expect(logger).to receive(:info).with(instance_of(Logr::Entry))
      entry.info
    end
  end

  describe '#warn' do
    it 'should call logger.warn with Entry object' do
      expect(logger).to receive(:warn).with(instance_of(Logr::Entry))
      entry.warn
    end

  end

  describe '#error' do
    it 'should call logger.error with Entry object' do
      expect(logger).to receive(:error).with(instance_of(Logr::Entry))
      entry.error
    end

  end

  describe '#fatal' do
    it 'should call logger.fatal with Entry object' do
      expect(logger).to receive(:fatal).with(instance_of(Logr::Entry))
      entry.fatal
    end
  end
 end
