class DueDatesTest < TLDR
  def test_parsing_dates_with_no_time
    t = JetTask::Task.from_string("Task @due(2024-11-08)")

    assert_equal Time.new(2024, 11, 8, 23, 59, 59), t.due_at
  end

  def test_parsing_dates_and_times
    t = JetTask::Task.from_string("Task @due(2024-11-08 12:00:00)")

    assert_equal Time.new(2024, 11, 8, 12, 0, 0), t.due_at
  end

  def test_parsing_gibberish
    t = JetTask::Task.from_string("Task @due(asdf)")

    assert_nil t.due_at
  end

  def test_parsing_relative_value
    t = JetTask::Task.from_string("Task @due(Saturday)")

    assert t.due_at < (Date.today + 8).to_time
  end

  def test_support_for_some_relative_values
    t = JetTask::Task.from_string("Task @due(Today)")

    assert t.due_at < (Date.today + 1).to_time
  end

end