
module JetTask
  class Project
    attr_accessor :name, :tasks, :notes
    include Taggable

    def initialize(name: "Untitled", tags: [], tasks: [], notes: [])
      @name = name
      @tags = tags
      @tasks = tasks
      @notes = notes
    end
  end
end