defmodule Mango.CRM.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.CRM.Customer


  schema "customers" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :phone, :string
    field :residence_area, :string

    timestamps()
  end

  @doc false
  def changeset(%Customer{} = customer, attrs) do
    customer
    |> cast(attrs, [:name, :email, :phone, :residence_area, :password])
    |> validate_required([:name, :email, :phone, :residence_area, :password])
    |> validate_length(:email, min: 1, max: 150)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/, message: "is invalid")
    |> validate_length(:password, min: 6, max: 100)
    |> put_hashed_password
  end

  def put_hashed_password(changeset) do
    case changeset.valid? do
      true ->
        changes = changeset.changes
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(changes.password))
      _ ->
        changeset
    end
  end

end
