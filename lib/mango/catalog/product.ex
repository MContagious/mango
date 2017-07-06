defmodule Mango.Catalog.Product do
  use Ecto.Schema

  schema "products" do
    field :sku, :string
    field :name, :string
    field :price, :decimal
    field :image, :string
    field :is_seasonal, :boolean, default: false
    field :category, :string
    field :pack_size, :string

    timestamps()
  end

end
