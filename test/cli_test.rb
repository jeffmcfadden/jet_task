class CliTest < TLDR

  def setup
    @cli = JetTask::CLI.new
  end

  def test_init
    return not_yet_implemented

    cmd = ["init", "Test Project Alpha"]
    run_cmd cmd
  end

  def test_add_task
    cmd = ["add_task", "Test Project Beta", "a", "new", "idea"]

    run_cmd cmd

    assert_equal "a new idea", @cli.manager.projects.named("Test Project Beta").tasks.last.name
  end

  private
  def run_cmd(cmd)
    # Use the test data:
    cmd += ["-f", "test/data/sample_projects_01.txt"]

    @cli.run(cmd)
  end

end