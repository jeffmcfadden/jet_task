module JetTask
  class Tag
    attr_accessor :name, :value

    def initialize(name:, value: nil)
      @name = name.to_s.strip
      @value = value

      if ["due", "start", "end"].include? @name
        attempt_to_parse_value_into_time
      end
    end

    # Returns true if the two tag names match
    # @param [JetTask::Tag] other
    def ==(other)
      self.name == other.name
    end

    # Returns true if the two tag names _and_ values match
    # @param [JetTask::Tag] other
    def ===(other)
      self.name == other.name && self.value == other.value
    end

    private

    def attempt_to_parse_value_into_time
      return nil if @value.nil?

      if @value.downcase == "today"
        now = Time.now
        @value = Time.new(now.year, now.month, now.day, 23, 59, 59)
        return
      end

      if @value.downcase == "tomorrow"
        tomorrow = Time.now + 86400
        @value = Time.new(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59, 59)
        return
      end

      # First option is to try to match YYYY-MM-DD HH:MM:SS
      begin
        da = Time.strptime(@value, "%Y-%m-%d %H:%M:%S")
        @value = da
        return
      rescue ArgumentError
        # Just keep moving for now.
      end

      # Second is to try to match YYYY-MM-DD, turn it into a Time object, and return it at 23:59:59
      begin
        da = Time.parse(Date.parse(@value).to_s + " 23:59:59")
        @value = da
        return
      rescue ArgumentError
        # Just keep moving for now.
      end

      # Last try is to just throw it at Time.parse and hope it works.
      begin
        da = Time.parse(@value)
        @value = da
        return
      rescue ArgumentError
      end
    end

  end
end