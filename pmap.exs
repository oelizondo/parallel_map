# Module for Parallel Map
defmodule ParallelMap do
  def map(collection, function) do
    # passes sself to a variable, essentially, the stack needs to receive another PID
    # to identify singular processes.
    me = self
    collection
      # Iterates over the collection, each spawning a different process.
      # Each spawn is linked and at the end returns a collection of PIDs
      # Each process sends its pid, and the execution of the function.
      |> Enum.map(fn element -> 
        spawn_link(fn -> (send me, { self, function.(element) }) end)
      end)
      # Iterates over the PIDs passed down from the last enum
      # the ^pid makes sure that the order in which the processes are returned are 
      # in order (some processes take less time than others).
      # returns the result for each PID.
      |> Enum.map(fn pid ->
        receive do
          {^pid, result} -> result
        end
      end)
  end
end