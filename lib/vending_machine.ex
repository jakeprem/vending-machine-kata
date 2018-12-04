defmodule VendingMachine do
  alias VendingMachine.Controller.Server
  alias VendingMachine.{
    Display,
    CoinReturn,
    DropBox
  }

  def insert_coin(coin) do
    Server.insert_coin(coin)
  end

  def get_display do
    Display.get()
  end
end
