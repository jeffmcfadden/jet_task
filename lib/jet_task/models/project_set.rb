module JetTask
  class ProjectSet
    include Enumerable

    attr_reader :projects
    
    def initialize(projects: [])
      @projects = projects.map{ [_1.name.downcase, _1] }.to_h
    end

    def add(project)
      if project.is_a?(String)
        project = project.new(name: project)
      end

      @projects[project.name.downcase] = project
    end

    alias_method :+, :add
    alias_method :<<, :add

    def remove(project)
      @projects.delete(project.name.downcase)
    end

    alias_method :-, :remove

    # Returns the project with the given name, or nil if not found
    # @param [String] name
    # @return [JetTask::Project, nil]
    def named(name)
      return nil if name.to_s.strip.empty?
      @projects[name.downcase]
    end

    def size
      @projects.size
    end

    alias_method :length, :size
    alias_method :count, :size

    def each(&block)
      @projects.values.each(&block)
    end


  end
end