defmodule SampleWeb.UserHTML do
  use SampleWeb, :html

  embed_templates "user_html/*"

  @doc """
  Renders a user form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def user_form(assigns)

  def form_search(assigns) do
    ~H"""
    <div id="form-search">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
