defmodule VendingMachine.ServerTest do
  use ExUnit.Case, async: true

  alias VendingMachine.Controller.Server

  @quarter {:coin, 5.67, 24.257}
  @nickel {:coin, 5.0, 21.209}
  @dime {:coin, 2.268, 17.907}
  @invalid {:coin, 10, 3}

  setup do
    Application.stop(:your_app)
    :ok = Application.start(:your_app)
  end

  test "displays 'INSERT COIN' when no coins inserted" do
    assert Server.get_display() == "INSERT COIN"
  end

  test "displays '$0.40' after inserting quarter, nickel, and dime" do
    Server.insert_coin(@quarter)
    Server.insert_coin(@nickel)
    Server.insert_coin(@dime)

    assert Server.get_display() == "$0.40"
  end

  test "displays '$1.65' after inserting several coins" do
    for _ <- 1..5, do: Server.insert_coin(@quarter)

    Server.insert_coin(@quarter)
    Server.insert_coin(@nickel)
    Server.insert_coin(@dime)

    assert Server.get_display() == "$1.65"
  end

  test "displays '$10.00' after inserting 40 quarters" do
    for _ <- 1..40, do: Server.insert_coin(@quarter)

    assert Server.get_display() == "$10.00"
  end

  test "rejects invalid coins" do
    Server.insert_coin(@invalid)

    assert Server.get_coin_return() == [@invalid]
    assert Server.get_display() == "INSERT COIN"
  end

  test "select product with enough money" do
    # Should dispense product and update display to Thank You
    # Can use a timed send to return display to INSERT COIN after
    # a set amount of time
  end

  test "select product with not enough money" do
    # Should update display to PRICE $X.xx
    # Can do a timeout to return to INSERT COIN,
    # or possibly toggle?
    # Looks like we're gonna have to design the display
    # soon
  end
end
