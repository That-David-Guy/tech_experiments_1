defmodule TechExperiments1Web.MUMCharacterLive.CharacterComponent do
  @moduledoc """
  Used for the character icon on the map
  """
  use TechExperiments1Web, :live_component

  alias TechExperiments1.MUM

  # Note: Don't have to use template for small html, could just use render(assign)

  def handle_event("teleport", _, socket) do
    MUM.telelport(socket.assigns.character)

    # Our system will trigger the update, not the return of this call
    {:noreply, socket}
  end

  def handle_event("dragged", params, socket) do
    require Logger
    Logger.debug("dragged: #{inspect params}")
    MUM.update_mum_character(socket.assigns.character, params)

    # Our system will trigger the update, not the return of this call
    {:noreply, socket}
  end

end
