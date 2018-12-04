defmodule VendingMachine.Controller.Server do
  use GenServer

  alias VendingMachine.Controller.Logic

  alias VendingMachine.CoinReturn
  alias VendingMachine.Display
  alias VendingMachine.DropBox

  defmodule State do
    defstruct coins: []
  end

  ##############
  # Client API #
  ##############
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def insert_coin({:coin, _weight, _diameter} = coin) do
    GenServer.cast(__MODULE__, {:insert, coin})
  end

  def select_product(product) do
    GenServer.cast(__MODULE__, {:select_product, product})
  end

  ####################
  # Server Callbacks #
  ####################
  def init(_args) do
    {:ok, %State{}}
  end

  def handle_cast({:insert, coin}, state) do
    state =
      case Logic.classify_coin(coin) do
        {:invalid, coin} ->
          CoinReturn.add_coin(coin)
        valid_coin ->
            state
            |> add_coin(valid_coin)
            |> update_display_value()
      end


    {:noreply, state}
  end
  def handle_cast({:select_product, _product}, state) do
    {:noreply, state}
  end

  #####################
  # Private Functions #
  #####################
  defp add_coin(state, coin), do: %State{state | coins: [coin | state.coins]}

  defp update_display_value(state) do
    Logic.get_coin_value_display(state.coins)
      |> Display.set()

    state
  end
end
