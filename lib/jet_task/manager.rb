module JetTask
  class Manager
    attr_accessor :projects, :global_tasks, :notes

    # Load a Manager from an IO object
    # @param io [IO]
    # @return [JetTask::Manager]
    def self.load(io)
      parser = JetTask::Parser.new
      parser.parse(io)
      new(projects: parser.projects, global_tasks: parser.global_tasks, notes: parser.notes)
    end

    def initialize(projects: [], global_tasks: [], notes: [])
      @projects = ProjectSet.new(projects: projects)
      @global_tasks = TaskSet.new(tasks: global_tasks)
      @notes = notes
    end

    def save(io)
      JetTask.logger.debug "Manager#save"
      serializer = TaskPaperSerializer.new(projects: @projects, global_tasks: @global_tasks, notes: @notes)
      serializer.write(io)
    end

    def add_task(task_string:,project_name:)
      project = @projects.named(project_name)
      if project.nil?
        project = @projects.add(Project.new(name: project_name))
      end

      task = Task.new(name: task_string)
      project.tasks << task
    end

    def add_project(project_name:)
      project = @projects.named(project_name)
      if project.nil?
        @projects.add(Project.new(name: project_name))
      end
    end



  end
end