defmodule VendingMachine.ServerTest do
  use ExUnit.Case, async: true

  alias VendingMachine.DropBox

  setup do
    drop_box = start_supervised!(VendingMachine.DropBox)
    %{drop_box: drop_box}
  end

  test "adds items correctly" do
    assert Agent.get(VendingMachine.DropBox, fn x -> x end) == []

    DropBox.add_item(:cookies)

    assert DropBox.look_items() == [:cookies]
  end

  test "adds several items correctly" do
    assert Agent.get(VendingMachine.DropBox, fn x -> x end) == []

    DropBox.add_item(:cookies)
    DropBox.add_item(:chips)
    DropBox.add_item(:soda)

    assert DropBox.look_items() == [:soda, :chips, :cookies]
  end

  test "retrieves items correctly" do
    assert Agent.get(VendingMachine.DropBox, fn x -> x end) == []

    DropBox.add_item(:cookies)
    DropBox.add_item(:chips)

    assert DropBox.retrieve_items() == [:chips, :cookies]
    assert Agent.get(VendingMachine.DropBox, fn x -> x end) == []
  end



end
