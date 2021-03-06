defmodule VendingMachine.Display do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> "UNINITIALIZED" end, name: __MODULE__)
  end

  # A GenServer would probably be more flexible and clearer here
  def get() do
    Agent.get_and_update(__MODULE__, fn
      [tail] -> {tail, tail}
      [head | tail] -> {head, tail}
      display -> {display, display}
    end)
  end

  def set(new_display) do
    Agent.update(__MODULE__, fn _display -> new_display end)
  end
end
