defmodule Mango.CRM do
  alias Mango.Repo
  alias Mango.CRM.Customer

  def build_customer(attrs \\ %{}) do
      %Customer{}
        |> Customer.changeset(attrs)
  end

  def create_customer(customer_params) do
      customer_params
        |> build_customer
        |> Repo.insert
  end

  def get_customer(id) do
      Customer
        |> Repo.get(id)
  end

  def get_customer_by_email(email), do: Repo.get_by(Customer, email: email)

  def get_customer_by_credentiasl(%{"email" => email, "password" => password}) do
    customer = get_customer_by_email(email)

    cond do
      customer && Comeonin.Bcrypt.checkpw(password, customer.password_hash) ->
        {:ok, customer}
      true ->
        {:error}
    end

  end

end
