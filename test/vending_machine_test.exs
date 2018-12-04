defmodule VendingMachineTest do
  use ExUnit.Case, async: false
  doctest VendingMachine

  @quarter {:coin, 5.67, 24.257}
  @nickel {:coin, 5.0, 21.209}
  @dime {:coin, 2.268, 17.907}
  @invalid {:coin, 10, 3}

  setup do
    Application.stop(:vending_machine)
    :ok = Application.start(:vending_machine)
  end

  test "displays 'INSERT COIN' when no coins inserted" do
    assert VendingMachine.get_display() == "INSERT COIN"
  end

  test "displays '$0.40' after inserting quarter, nickel, and dime" do
    VendingMachine.insert_coin(@quarter)
    VendingMachine.insert_coin(@nickel)
    VendingMachine.insert_coin(@dime)
    VendingMachine.insert_coin(@invalid)

    assert VendingMachine.get_display() == "$0.40"
  end


end
