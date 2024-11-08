require "optionparser"

module JetTask
  class CLI

    attr_reader :options_parser, :options, :manager

    def initialize
      @options = {}

      @options_parser = OptionParser.new do |opts|
        opts.banner = "Usage: jet_task [options]"

        # Allow --file option for passing in the project file
        opts.on("-fPROJECTSFILE", "--projects_file=PROJECTSFILE", "The projects file to use") do |f|
          @options[:projects_file] = f
        end

        opts.on("-h", "--[no-]help", "Get help") do |h|
          @options[:help] = h
        end

        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          @options[:verbose] = v
        end

        opts.on("-d", "--[no]debug", "Run with debugging level output") do |d|
          @options[:debug] = d
        end
      end
    end

    def run(args)
      JetTask.logger.level = @options[:debug] ? :debug : :warn

      begin
        @options_parser.parse!(args, into: @options)
      rescue OptionParser::InvalidOption => error
        puts "ERROR: #{error.message}"
        exit!
      end

      # How are we going to load this?
      @manager = Manager.load(File.open(resolved_projects_file))

      command_name = args.shift

      if command_name == "get_completions"
        cmd, prev, cur = ARGV[0], ARGV[1], ARGV[2]

        l = Logger.new("completions.log")
        l.debug "get_completions called with #{cmd}, #{prev}, #{cur}"

        cmds = ["add_task", "add_project", "projects", "view"]

        if prev == "jt"
          if !cur.empty?
            puts cmds.select{ _1.start_with? cur }
          else
            puts cmds
          end
        end

        if prev == "add_task"
          if !cur.empty?
            puts @manager.projects.select{ _1.name.downcase.start_with? cur.downcase }.map{ _1.name }
          else
            puts @manager.projects.select{ _1.name.downcase }.map{ _1.name }
          end
        end


      elsif command_name == "add_task"
        project_name = args.shift
        task_string = args.join(" ")
        @manager.add_task(project_name: project_name, task_string: task_string)
        @manager.save(File.open(resolved_projects_file, "w"))
      elsif command_name == "add_project"
        project_name = args.shift
        @manager.add_project(project_name: project_name)
        @manager.save(File.open(resolved_projects_file, "w"))
      elsif command_name == "projects"
        @manager.projects.each{ |p| puts p.name }
      elsif command_name == "touch" # Just re-serializes everything. Useful for nudging relative dates, etc.
        @manager.save(File.open(resolved_projects_file, "w"))
      elsif command_name == "view"
        project_name = args.first
        p = @manager.projects.named(project_name)
        if p.nil?
          puts "Project \"#{project_name}\" not found."
          return
        end

        puts p.name
        p.tasks.each do |t|
          puts "- [#{t.complete? ? 'x' : ' '}] #{t.name}"
        end

      elsif @options[:help]
        puts "JetTask version #{VERSION}"
        puts "Default projects file is projects.txt"
        puts "Usage: $ jt add_task MyProject This is my task"
      end

      # puts "JetTask version #{VERSION}"
      #
      # puts "Run with options:"
      # puts @options
      #
      # puts "args is now:"
      # puts args
    end

    def resolved_projects_file
      @options[:projects_file] || "projects.txt"
    end

  end


end