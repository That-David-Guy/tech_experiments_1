defmodule TechExperiments1Web.LVTEBallLive.FormComponent do
  use TechExperiments1Web, :live_component

  alias TechExperiments1.LVTE

  @impl true
  def update(%{lvte_ball: lvte_ball} = assigns, socket) do
    changeset = LVTE.change_lvte_ball(lvte_ball)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"lvte_ball" => lvte_ball_params}, socket) do
    changeset =
      socket.assigns.lvte_ball
      |> LVTE.change_lvte_ball(lvte_ball_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"lvte_ball" => lvte_ball_params}, socket) do
    save_lvte_ball(socket, socket.assigns.action, lvte_ball_params)
  end

  defp save_lvte_ball(socket, :edit, lvte_ball_params) do
    case LVTE.update_lvte_ball(socket.assigns.lvte_ball, lvte_ball_params) do
      {:ok, _lvte_ball} ->
        {:noreply,
         socket
         |> put_flash(:info, "Lvte ball updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_lvte_ball(socket, :new, lvte_ball_params) do
    case LVTE.create_lvte_ball(lvte_ball_params) do
      {:ok, _lvte_ball} ->
        {:noreply,
         socket
         |> put_flash(:info, "Lvte ball created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
