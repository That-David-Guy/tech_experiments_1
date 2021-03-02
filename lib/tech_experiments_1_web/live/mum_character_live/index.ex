defmodule TechExperiments1Web.MUMCharacterLive.Index do
  use TechExperiments1Web, :live_view

  alias TechExperiments1.MUM
  alias TechExperiments1.MUM.MUMCharacter

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: MUM.subscribe()

    {:ok,
      assign(socket, :mum_characters, list_mum_characters())
      # temporary_assigns: [mum_characters: []] #stops delete from working
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Mum character")
    |> assign(:mum_character, MUM.get_mum_character!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Mum character")
    |> assign(:mum_character, %MUMCharacter{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mum characters")
    |> assign(:mum_character, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    mum_character = MUM.get_mum_character!(id)
    {:ok, _} = MUM.delete_mum_character(mum_character)

    {:noreply, assign(socket, :mum_characters, list_mum_characters())}
  end

  @impl true
  def handle_info({:mum_character_created, character}, socket) do
    {:noreply, update(socket, :mum_characters, fn characters -> [character | characters] end)}
  end

  @impl true
  def handle_info({:mum_character_updated, character}, socket) do
    {:noreply, update(socket, :mum_characters, fn characters -> [character | characters] end)}
  end

  @impl true
  def handle_info({:mum_character_deleted, character}, socket) do
    {:noreply, update(socket, :mum_characters,
      fn characters ->
        Enum.filter(characters, fn c -> c.id != character.id end)
    end)
    }
  end

  def handle_event("mum_quick_create", _, socket) do
    MUM.quick_create()
    {:noreply, socket}
  end

  def handle_event("mum_quick_delete", _, socket) do
    MUM.quick_delete()
    {:noreply, socket}
  end

  defp list_mum_characters do
    MUM.list_mum_characters()
  end
end
