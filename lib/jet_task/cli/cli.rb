module JetTask
  class CLI

    attr_reader :options_parser, :options

    def initialize
      @options = {}

      @options_parser = OptionParser.new do |opts|
        opts.banner = "Usage: jet_task [options]"

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          @options[:verbose] = v
        end
      end


    end
  end

end