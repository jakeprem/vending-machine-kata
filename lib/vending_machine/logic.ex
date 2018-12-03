defmodule VendingMachine.Logic do
  @coin_values %{
    quarter: 0.25,
    nickel: 0.05,
    dime: 0.10
  }

  def classify_coin({:coin, _weight = 5.67, _diameter = 24.257}), do: :quarter
  def classify_coin({:coin, _weight = 5.0, _diameter = 21.209}), do: :nickel
  def classify_coin({:coin, _weight = 2.268, _diameter = 17.907}), do: :dime
  def classify_coin({:coin, _weight, _diameter} = coin), do: {:invalid, coin}

  def calculate_value(coins) do
    coins
    |> Enum.reduce(0, fn coin, acc ->
      acc + @coin_values[coin]
    end)
  end
end
