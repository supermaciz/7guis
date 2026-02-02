defmodule SevenGUIsWeb.PageController do
  use SevenGUIsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
