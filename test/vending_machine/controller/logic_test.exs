defmodule VendingMachine.LogicTest do
  use ExUnit.Case, async: true

  import VendingMachine.Controller.Logic

  test "does this even work" do
    assert true
  end

  test "it should classify a quarter" do
    assert :quarter == classify_coin({:coin, 5.67, 24.257})
  end

  test "it should classify a nickel" do
    assert :nickel == classify_coin({:coin, 5.0, 21.209})
  end

  test "it should classify a dime" do
    assert :dime == classify_coin({:coin, 2.268, 17.907})
  end

  test "it should classify incorrect coins" do
    coin = {:coin, 10, 10}

    assert {:invalid, coin} == classify_coin(coin)
  end

  # test "it should accept valid coins" do
  #   assert [:quarter] == insert_coin({:coin, 5.67, 25.257})
  # end

  # test "it should not accept invalid coins" do

  # end
end
