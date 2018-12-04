defmodule VendingMachine.DisplayTest do
  use ExUnit.Case, async: true

  alias VendingMachine.Display

  test "set display works" do
    Display.set("A NEW VALUE")

    assert Display.get() == "A NEW VALUE"
  end

  test "set display multiple times" do
    Display.set("A")
    Display.set("B")
    Display.set("C")

    assert Display.get() == "C"
  end

  test "display resets after updating if next value set" do
    Display.set(["PRICE $1.00", "INSERT COIN"])

    assert Display.get() == "PRICE $1.00"
    assert Display.get() == "INSERT COIN"
  end
end
