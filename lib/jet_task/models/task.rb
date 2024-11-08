module JetTask
  class Task
    attr_accessor :name, :completed
    include Taggable

    def self.from_string(string)
      name, tags = Parser.new.extract_tags_and_values(string)
      new(name: name.strip, tags: tags)
    end

    # @param [Array<Tag>] tags
    def initialize(name: "Untitled", tags: [], completed: false)
      @name = name.strip
      @tags = TagSet.new(tags: tags)
      @completed = completed
    end

    def due_at
      tags.named("due")&.value if tags.named("due")&.value.is_a?(Time)
    end

    def overdue?
      return false if due_at.nil?
      due_at < Time.now
    end

    def start_at
      tags.named("start")&.value if tags.named("start")&.value.is_a?(Time)
    end

    def complete?
      @completed
    end

    def incomplete?
      !complete?
    end


  end
end