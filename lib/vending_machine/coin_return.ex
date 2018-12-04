defmodule VendingMachine.CoinReturn do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_coin(coin) do
    Agent.update(__MODULE__, fn coins -> [coin|coins] end)
  end

  def look_coins do
    Agent.get(__MODULE__, fn coins -> coins end)
  end

  def retrieve_coins do
    Agent.get_and_update(__MODULE__, fn coins -> {coins, []} end)
  end
end
