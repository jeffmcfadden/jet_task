require 'stringio'

class SerializerTest < TLDR

  def test_serialization
    manager = JetTask::Manager.load(File.open("test/data/sample_projects_01.txt"))

    output = StringIO.new

    JetTask::TaskPaperSerializer.new(
      projects: manager.projects,
      global_tasks: manager.global_tasks,
      notes: manager.notes).write(output)

    expected = "# Test Project A:\n- [ ] A task\n- [ ] B task @due(2021-12-31 23:59:59 -0700)\n- [ ] This is another task\n\n# Test Project Beta:\n- [ ] What is this @dunno(asdf)\n- [ ] a new idea\n\n"

    assert_equal expected, output.string
  end

end