defmodule Mango.Web.SessionController do
  use Mango.Web, :controller
  alias Mango.CRM

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
    case CRM.get_customer_by_credentiasl(session_params) do
      {:ok, customer} ->
        conn
          |> put_session(:current_customer, customer)
          |> put_session(:customer_id, customer.id)
          |> configure_session(renew: true)
          |> put_flash(:info, "Login successful")
          |> redirect(to: page_path(conn, :index))
      _ ->
        conn
          |> put_flash(:error, "Invalid username/password combination")
          |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
      |> clear_session
      |> put_flash(:info, "You have been logged out")
      |> redirect(to: page_path(conn, :index))
  end

end
