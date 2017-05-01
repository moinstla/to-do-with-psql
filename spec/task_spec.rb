require('rspec')
require('task')
require('pg')

DB ||= PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe(Task) do
  describe('.all') do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
      test_task.save()
      expected = test_task.clone
      expected.due_date = Time.parse(test_task.due_date)
      expect(Task.all()).to(eq([expected]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

    describe("#list_id") do
      it("lets your read the list ID out") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
        expect(test_task.list_id()).to(eq(1))
      end
    end

    describe("#due_date") do
      it("lets you read the due date of of the task") do
        test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
        expect(test_task.due_date()).to(eq("2017-05-01 00:00:00 -0700"))
      end
    end

  describe("#==") do
    it ("is the same task if it has the same task if it has the same description") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => "2017-05-01 00:00:00 -0700"})
      expect(task1).to(eq(task2))
    end
  end
end
