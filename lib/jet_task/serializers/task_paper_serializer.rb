module JetTask
  class TaskPaperSerializer

    def initialize(projects:, global_tasks:, notes:)
      @projects = projects
      @global_tasks = global_tasks
      @notes = notes
    end

    def write(io)
      @global_tasks.each do |task|
        write_task(io, task)
      end

      io.puts "" if @global_tasks.any?

      @projects.each do |project|
        io.puts "# #{project.name}:"
        project.tasks.each do |task|
          write_task(io, task)
        end

        io.puts ""
      end

      @notes.each do |note|
        io.puts note
      end
    end

    def write_task(io, task)
      io.print "- "

      if task.complete?
        io.print "[x] "
      else
        io.print "[ ] "
      end

      io.print task.name

      task.tags.each do |tag|
        io.print " @#{tag.name}"
        io.print "(#{tag.value})" if tag.value
      end
      io.print "\n"
    end


  end
end