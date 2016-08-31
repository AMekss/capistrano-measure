require 'spec_helper'
require 'capistrano/measure/timer'

describe Capistrano::Measure::Timer do
  describe "#start" do
    it "should increase events array" do
      expect(subject.events.size).to eq 0
      event = subject.start('test')
      expect(subject.events.size).to eq 1
      expect(subject.events.last).to eq event
    end

    it "should produce start event" do
      Timecop.freeze do
        event = subject.start('test')

        expect(event.name).to eq 'test'
        expect(event.action).to eq :start
        expect(event.time).to eq Time.now
        expect(event.elapsed_time).to be_nil
      end
    end

    it "should increase event's indent on every subsequent method call" do
      event = subject.start('test')
      expect(event.indent).to eq 0

      event = subject.start('test1')
      expect(event.indent).to eq 1
    end
  end

  describe "#stop" do
    before(:each) do
      subject.start('test')
      subject.start('test1')
    end

    it "should increase events array" do
      expect(subject.events.size).to eq 2
      event = subject.stop('test1')
      expect(subject.events.size).to eq 3
      expect(subject.events.last).to eq event
    end

    it "should produce stop event" do
      Timecop.freeze do
        event = subject.stop('test1')

        expect(event.name).to eq 'test1'
        expect(event.action).to eq :stop
        expect(event.time).to eq Time.now
      end
    end

    it "should calculate elapsed time for closed events" do
      Timecop.freeze do
        subject.start('test1')

        Timecop.travel(Time.now + 200) do
          event = subject.stop('test1')
          expect(event.elapsed_time).to eq 200
        end
      end
    end

    it "should decrease event's indent on every subsequent method call" do
      subject.stop('test1')
      event = subject.events.last
      expect(event.indent).to eq 1

      subject.stop('test')
      event = subject.events.last
      expect(event.indent).to eq 0
    end

    it "should raise exception with unstarted event" do
      expect{ subject.stop('test123') }.to raise_error(RuntimeError)
    end
  end

  describe "#report_events" do
    it "should raise exception if called in the middle of process" do
      subject.start('test')
      expect{ subject.report_events }.to raise_error(RuntimeError)
    end

    context "in completed state" do
      before(:each) do
        subject.start('test')
        subject.start('test1')
        subject.stop('test1')
        subject.stop('test')

        subject.start('test')
        subject.stop('test')
      end

      it { expect(subject.report_events).to be_a ::Enumerator }
      it { expect(subject.report_events.to_a.size).to eq 4 }
    end
  end

end
