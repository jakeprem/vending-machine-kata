defmodule VendingMachine.ServerTest do
  use ExUnit.Case, async: true

  alias VendingMachine.CoinReturn

  setup do
    coin_return = start_supervised!(VendingMachine.CoinReturn)
    %{coin_return: coin_return}
  end

  test "adds coins correctly" do
    assert Agent.get(VendingMachine.CoinReturn, fn x -> x end) == []

    CoinReturn.add_coin(:quarter)

    assert CoinReturn.look_coins() == [:quarter]
  end

  test "adds several coins correctly" do
    assert Agent.get(VendingMachine.CoinReturn, fn x -> x end) == []

    CoinReturn.add_coin(:quarter)
    CoinReturn.add_coin(:nickel)
    CoinReturn.add_coin(:dime)

    assert Coin.look_items() == [:dime, :nickel, :quarter]
  end

  test "retrieves coins correctly" do
    assert Agent.get(VendingMachine.CoinReturn, fn x -> x end) == []

    CoinReturn.add_coin(:quarter)
    CoinReturn.add_coin(:nickel)

    assert CoinReturn.retrieve_coins() == [:nickel, :quarter]
    assert Agent.get(VendingMachine.CoinReturn, fn x -> x end) == []
  end



end
