## Parallel Map

This is a simple exercise that imitates the ```Enum.map``` function in elixir, but using processes and all cpu processors.

```elixir
iex(1)> ParallelMap.map([1,2,3], &(&1 * &1))
[1,4,9]
```