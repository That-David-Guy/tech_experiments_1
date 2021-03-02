defmodule TechExperiments1Web.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `TechExperiments1Web.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, TechExperiments1Web.MUMCharacterLive.FormComponent,
        id: @mum_character.id || :new,
        action: @live_action,
        mum_character: @mum_character,
        return_to: Routes.mum_character_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, TechExperiments1Web.ModalComponent, modal_opts)
  end
end
