defmodule VendingMachine.Application do
  use Application

  def start(_types, _args) do
    children = [
      {VendingMachine.Display, starting_val: "INSERT COIN"},
      {VendingMachine.CoinReturn, []},
      {VendingMachine.DropBox, []},
      {VendingMachine.Controller.Server, []},
    ]

    opts = [strategy: :rest_for_one, name: VendingMachine]

    Supervisor.start_link(children, opts)
  end
end
