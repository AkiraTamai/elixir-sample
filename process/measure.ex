defmodule Measure do
  def count(pid) do
    receive do
     n -> send pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
             fn(_, send_to) -> spawn(Measure, :count, [send_to])
             end

    send last, 0

    receive do
      result when is_integer(result) -> "result is #{inspect(result)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Measure, :create_processes, [n])
  end
end

