require_relative 'view'
require_relative 'task'

class Controller # tells views and repos to invoke actions
  def initialize(repository) # expect argument to be an instance of a repo
    @view = View.new
    @repository = repository # repository instance
  end

  def add_task
    # view asks for the input
    description = @view.ask_for_description
    # instantiate a new task
    new_task = Task.new(description)
    # add them to the repository
    @repository.add(new_task)
  end

  def list
    # TODO: display all of the tasks
    # ask the repo to give all the tasks
    display_tasks
  end

  def mark_done
    # let the user see all the tasks
    display_tasks
    # ask the user for which task to mark
    index = @view.ask_user_for_index
    # TODO: update the state of the chosen task
    # ask repository to give me a task at index `index`
    task = @repository.find(index)
    # update the state of the task -> done
    task.completed!
  end

  def destroy
    # let the user see all the tasks
    display_tasks
    # ask the user for which task to delete
    index = @view.ask_user_for_index
    # tell the repo to delete the task at given index
    @repository.remove(index)
  end

  private

  def display_tasks
    tasks = @repository.all
    @view.display(tasks)
  end
end
