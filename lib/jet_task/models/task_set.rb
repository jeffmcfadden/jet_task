module JetTask
  class TaskSet
    include Enumerable

    attr_reader :tasks

    def initialize(tasks: [])
      @tasks = tasks.map{ [_1.name, _1] }.to_h
    end

    def add(task)
      if task.is_a?(String)
        task = task.new(name: task)
      end

      @tasks[task.name] = task
    end

    alias_method :+, :add
    alias_method :<<, :add

    def remove(task)
      @tasks.delete(task.name)
    end

    alias_method :-, :remove

    # Returns the task with the given name, or nil if not found
    # @param [String] name
    # @return [JetTask::task, nil]
    def named(name)
      @tasks[name]
    end

    def size
      @tasks.size
    end

    def overdue
      @tasks.values.select(&:overdue?)
    end

    def complete
      @tasks.values.select(&:complete?)
    end

    def incomplete
      @tasks.values.select(&:incomplete?)
    end

    alias_method :length, :size
    alias_method :count, :size

    def each(&block)
      @tasks.values.each(&block)
    end


  end
end