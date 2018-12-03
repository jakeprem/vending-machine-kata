defmodule VendingMachine.Controller.Server do
  use GenServer

  alias VendingMachine.Controller.Logic

  defmodule State do
    defstruct coins: [], display: "INSERT COIN", return: []
  end

  ##############
  # Client API #
  ##############
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_display do
    GenServer.call(__MODULE__, :get_display)
  end

  def get_coin_return do
    GenServer.call(__MODULE__, :get_coin_return)
  end

  def insert_coin({:coin, _weight, _diameter} = coin) do
    GenServer.cast(__MODULE__, {:insert, coin})
  end

  ####################
  # Server Callbacks #
  ####################
  def init(_args) do
    {:ok, %State{}}
  end

  def handle_call(:get_display, _from, state) do
    {:reply, state.display, state}
  end

  def handle_call(:get_coin_return, _from, %State{return: return} = state) do
    state = state |> clear_return()

    {:reply, return, state}
  end

  def handle_cast({:insert, coin}, state) do
    state =
      case Logic.classify_coin(coin) do
        {:invalid, coin} ->
          state |> return_coin(coin)

        valid_coin ->
          state
          |> add_coin(valid_coin)
          |> display_coin_value()
      end

    {:noreply, state}
  end

  #####################
  # Private Functions #
  #####################
  defp add_coin(state, coin), do: %State{state | coins: [coin | state.coins]}

  defp return_coin(state, coin), do: %State{state | return: [coin | state.return]}
  defp clear_return(state), do: %State{state | return: []}

  defp update_display(state, display_text), do: %{state | display: display_text}
  # -------------------
  defp display_insert_coin(state) do
    update_display(state, "INSERT COIN")
  end

  defp display_coin_value(state) do
    val = Logic.calculate_value(state.coins)

    new_display = "$#{val}" |> pad_zero()

    update_display(state, new_display)
  end

  # This should be handled using an actual currency library
  defp pad_zero(display) do
    [dollars, cents] = String.split(display, ".")
    dollars <> "." <> String.pad_trailing(cents, 2, "0")
  end
end
