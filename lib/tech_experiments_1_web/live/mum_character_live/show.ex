defmodule TechExperiments1Web.MUMCharacterLive.Show do
  use TechExperiments1Web, :live_view

  alias TechExperiments1.MUM

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:mum_character, MUM.get_mum_character!(id))}
  end

  defp page_title(:show), do: "Show Mum character"
  defp page_title(:edit), do: "Edit Mum character"
end
