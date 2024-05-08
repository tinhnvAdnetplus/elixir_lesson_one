defmodule SampleWeb.TestLive do
  use SampleWeb, :live_view

  # tương ứng tạo file live_test.html.heex
  # 
  # def render(assigns) do
  #   ~H"""
  #   <h1><%= @text %></h1>
  #   <button phx-click="change_text">Click here!</button>
  #   """
  # end

  def mount(params, _session, socket) do
    IO.inspect(params)
    {:ok, assign(socket, :text, "LiveView2")}
  end

  def handle_event("change_text", _params, socket) do
    {:noreply, assign(socket, :text, "Clicked LiveView Event")}
  end
end
