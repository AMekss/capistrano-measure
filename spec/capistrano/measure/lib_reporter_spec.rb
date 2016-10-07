require 'capistrano/measure/log_reporter'

LogItem = Struct.new(:indent, :name, :elapsed_time)

RSpec.describe Capistrano::Measure::LogReporter do
  let(:logger) { ::StringLogger.new }
  let(:config) { {} }
  subject { Capistrano::Measure::LogReporter.new(logger, config) }

  describe "#render" do
    {green: [0, 30], yellow: [31, 60], red: [61, 100]}.each do |color, times|
      times.each do |elapsed_time|
        it "should render line with time in #{color} when elapsed time eq #{elapsed_time}" do
          subject.render([LogItem.new(0, 'test', elapsed_time)])
          colorized_time = ColorizedString["#{elapsed_time}s"].colorize(color)

          expect(logger.to_s).to include("test #{colorized_time}\n")
        end
      end
    end

    context "with changed thresholds" do
      let(:config) { { warning_threshold: 20, alert_threshold: 30 } }

      {green: [0, 20], yellow: [21, 30], red: [31, 100]}.each do |color, times|
        times.each do |elapsed_time|
          it "should render line with time in #{color} when elapsed time eq #{elapsed_time}" do
            subject.render([LogItem.new(0, 'test', elapsed_time)])
            colorized_time = ColorizedString["#{elapsed_time}s"].colorize(color)

            expect(logger.to_s).to include("test #{colorized_time}\n")
          end
        end
      end
    end

    it "should not render empty report" do
      subject.render([])
      expect(logger.to_s).to eq ""
    end

    it "should include title" do
      subject.render([LogItem.new(0, 'test')])
      expect(logger.to_s).to include("Performance Report")
    end

    it "should render line without time if it missing" do
      subject.render([LogItem.new(0, 'test')])
      expect(logger.to_s).to include("test \n")
    end

    it "should render items with indention" do
      subject.render([LogItem.new(1, 'test1'), LogItem.new(2, 'test2')])
      expect(logger.to_s).to include("..test1 \n")
      expect(logger.to_s).to include("....test2 \n")
    end
  end

end
