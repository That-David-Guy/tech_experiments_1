defmodule TechExperiments1Web.TailwindcssLive.Index do
  @moduledoc """
  Main page for the Mutli User Map Tech Experiment
  """
  use TechExperiments1Web, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end

end
