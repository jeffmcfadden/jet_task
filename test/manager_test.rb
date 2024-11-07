class ManagerTest < TLDR
  def test_basic_loading
    task_paper_sample = <<-TP
- [ ] Global Task 1
- Global task 2 @done @today @project_sigma

Project Alpha:
- Task 1 @done
- Task 2 @today

This is a note to myself
I hope I don't forget anything
And that I remember all the details

- This will be a Project Alpha task

Project Beta @project_tag:
- Task 1
- [x] Did this one
- [ ] Do this one
    TP

    manager = JetTask::Manager.load(task_paper_sample)

    assert_equal 2, manager.global_tasks.size
    assert_equal 2, manager.projects.size

    assert_equal "Project Alpha", manager.projects.first.name
    assert_equal 3, manager.projects.first.tasks.size

    assert_equal 1, manager.notes.size
    assert_equal "This is a note to myself\nI hope I don't forget anything\nAnd that I remember all the details\n", manager.notes.first
  end
end