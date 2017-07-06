# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mango.Repo.insert!(%Mango.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mango.Repo
alias Mango.Catalog.Product

alias NimbleCSV.RFC4180, as: CSV

"priv/seed_data/products_list.csv"
  |> File.read!
  |> CSV.parse_string()
  |> Enum.each(fn [_, name, price, sku, is_seasonal, image, pack_size, catagory]  ->
    is_seasonal = String.to_existing_atom(is_seasonal)
    price = Decimal.new(price)
    product = %Product{name: name,
      price: price,
      sku: sku,
      is_seasonal: is_seasonal,
      image: image,
      pack_size: pack_size,
      category: catagory
    }
    IO.inspect(product)

    product
      |> Repo.insert!()

   end)
