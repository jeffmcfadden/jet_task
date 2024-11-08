module JetTask
  class Tag
    attr_accessor :name, :value

    def initialize(name:, value: nil)
      @name = name.to_s.strip
      @value = value
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

  end
end