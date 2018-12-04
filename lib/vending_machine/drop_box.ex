defmodule VendingMachine.DropBox do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_item(item) do
    Agent.update(__MODULE__, fn items -> [item|items] end)
  end

  def look_items do
    Agent.get(__MODULE__, fn items -> items end)
  end

  def retrieve_items do
    Agent.get_and_update(__MODULE__, fn items -> {items, []} end)
  end
end
