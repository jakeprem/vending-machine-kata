defmodule VendingMachine.DisplayTest do
  use ExUnit.Case, async: true

  alias VendingMachine.Display

  setup do
    display = start_supervised!(VendingMachine.Display)
    %{display: display}
  end

  test "set display works" do
    assert Display.get() == "UNINITIALIZED"

    Display.set("A NEW VALUE")

    assert Display.get() == "A NEW VALUE"
  end

  test "display resets after updating if next value set" do
    assert Display.get() == "UNINITIALIZED"

    Display.set(["PRICE $1.00", "INSERT COIN"])

    assert Display.get() == "PRICE $1.00"
    assert Display.get() == "INSERT COIN"
  end
end
