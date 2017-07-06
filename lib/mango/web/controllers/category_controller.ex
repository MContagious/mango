defmodule Mango.Web.CategoryController do
  use Mango.Web, :controller
  alias Mango.Catalog

  def index(conn, %{"name" => category_name}) do
    products = Catalog.list_products_by_category(category_name)
    render conn, "index.html", category_name: category_name, products: products
  end
end
