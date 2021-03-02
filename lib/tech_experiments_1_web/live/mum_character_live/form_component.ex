defmodule TechExperiments1Web.MUMCharacterLive.FormComponent do
  @moduledoc """
  Form to create a character
  """
  use TechExperiments1Web, :live_component

  alias TechExperiments1.MUM

  @impl true
  def update(%{mum_character: mum_character} = assigns, socket) do
    changeset = MUM.change_mum_character(mum_character)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"mum_character" => mum_character_params}, socket) do
    changeset =
      socket.assigns.mum_character
      |> MUM.change_mum_character(mum_character_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"mum_character" => mum_character_params}, socket) do
    save_mum_character(socket, socket.assigns.action, mum_character_params)
  end

  defp save_mum_character(socket, :edit, mum_character_params) do
    case MUM.update_mum_character(socket.assigns.mum_character, mum_character_params) do
      {:ok, _mum_character} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mum character updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_mum_character(socket, :new, mum_character_params) do
    case MUM.create_mum_character(mum_character_params) do
      {:ok, _mum_character} ->
        {:noreply,
         socket
         |> put_flash(:info, "Mum character created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
