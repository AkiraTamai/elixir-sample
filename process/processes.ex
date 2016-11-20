defmodule Processes do
  def message do
    receive do
      {sender, msg} -> send sender, { :ok, "received, #{msg}" }
      # 単純な再帰：memoryを考慮するため本来は末尾再帰を使うこと
      message
    end
  end
end

# client
pid = spawn(Processes, :message, [])
send pid, {self, "msg!"}

receive do
  { :ok, message } -> IO.puts message
end

send pid, {self, "twice!"}
receive do
  { :ok, message } -> IO.puts message
  after 500 -> IO.puts "gone away!"
end
