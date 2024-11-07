module JetTask
  class Task
    attr_accessor :name, :completed
    include Taggable

    def initialize(name: "Untitled", tags: [], completed: false)
      @name = name
      @tags = tags
      @completed = completed
    end

    def due_at
      da = tags.named("due")&.value
      return nil if da.nil?
      Time.parse(da)
    end

    def overdue?
      return false if due_at.nil?
      due_at < Time.now
    end

    def start_at
      sa = tags.named("due")&.value
      return nil if sa.nil?
      Time.parse(sa)
    end

  end
end