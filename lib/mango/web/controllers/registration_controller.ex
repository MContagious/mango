defmodule Mango.Web.RegistrationController do
  use Mango.Web, :controller
  alias Mango.CRM

  def new(conn, _) do
    changeset = CRM.build_customer()
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"registration" => registration_data}) do
    case CRM.create_customer(registration_data) do
      {:ok, _customer} ->
        conn
          |> put_flash(:info, "Registration successful")
          |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

end
