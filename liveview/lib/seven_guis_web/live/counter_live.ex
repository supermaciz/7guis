defmodule SevenGUIsWeb.CounterLive do
  use SevenGUIsWeb, :live_view

  def render(assigns) do
    ~H"""
    {@count}
    <.button phx-click="inc_counter">Count</.button>
    """
  end

  def mount(_params, _session, socket) do
    count = 0
    {:ok, assign(socket, :count, count)}
  end

  def handle_event("inc_counter", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end
