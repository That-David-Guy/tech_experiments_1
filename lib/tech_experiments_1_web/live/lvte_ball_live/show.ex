defmodule TechExperiments1Web.LVTEBallLive.Show do
  use TechExperiments1Web, :live_view

  alias TechExperiments1.LVTE

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:lvte_ball, LVTE.get_lvte_ball!(id))}
  end

  defp page_title(:show), do: "Show Lvte ball"
  defp page_title(:edit), do: "Edit Lvte ball"
end
