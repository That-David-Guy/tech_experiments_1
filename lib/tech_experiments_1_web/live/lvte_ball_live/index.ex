defmodule TechExperiments1Web.LVTEBallLive.Index do
  use TechExperiments1Web, :live_view

  alias TechExperiments1.LVTE
  alias TechExperiments1.LVTE.LVTEBall

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :lvte_balls, list_lvte_balls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Lvte ball")
    |> assign(:lvte_ball, LVTE.get_lvte_ball!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Lvte ball")
    |> assign(:lvte_ball, %LVTEBall{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Lvte balls")
    |> assign(:lvte_ball, nil)
  end

  # @impl implies that this function is a callback
  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    lvte_ball = LVTE.get_lvte_ball!(id)
    {:ok, _} = LVTE.delete_lvte_ball(lvte_ball)

    {:noreply, assign(socket, :lvte_balls, list_lvte_balls())}
  end

  # def handle_event("elm_client_intialised", _, socket) do
  #   require Logger
  #   Logger.debug "\n\nelm_client_intialised\n\n"
  #   # Send all information to everyone
  #   {:noreply, socket}
  #   # {:noreply, assign(socket, :lvte_balls, list_lvte_balls())}
  #   # {:noreply, "elm_client_intialised", assign(socket, :lvte_balls, list_lvte_balls())}
  # end

  def handle_event("new_client_initialised", payload, socket) do
    latest_balls = list_lvte_balls()
    updated_socket = assign(socket, :lvte_balls, latest_balls)
    payload = %{
      event_name: "new_client_initialised",
      event_data: LVTE.to_list_of_maps(latest_balls)
    }

    # NOTE:!!! You need to transform the ecto struct to a map before sending as event payload
    {:noreply, push_event(updated_socket, payload.event_name, payload)}
  end

  def handle_event(event_name, _, socket) do
    require Logger
    Logger.debug "\n\n#{event_name} not recognised\n\n"
    # Send all information to everyone
    {:noreply, socket}
    # {:noreply, assign(socket, :lvte_balls, list_lvte_balls())}
    # {:noreply, "elm_client_intialised", assign(socket, :lvte_balls, list_lvte_balls())}
  end

  defp list_lvte_balls do
    LVTE.list_lvte_balls()
  end
end
