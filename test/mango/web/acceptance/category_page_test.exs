defmodule Mango.Web.Acceptence.CategoryPageTest do
  use Mango.DataCase
  use Hound.Helpers

  hound_session()

  setup do

    alias Mango.Repo
    alias Mango.Catalog.Product

    ## GIVEN ##
    # There are two products Apple and Tomato priced 100 and 50
    # categorized under `fruits` and `vegetables` respectively
    Repo.insert %Product{name: "Tomato", price: 50, sku: "A123", is_seasonal: false, category: "vegetables"}
    Repo.insert %Product{name: "Apple", price: 100, sku: "A232", is_seasonal: true, category: "fruits"}

    :ok
  end

  test "Show fruits" do
    ## WHEN ##
    # I navigate to fruits page
    navigate_to("/categories/fruits")

    ## THEN ##
    # I expect the page title to be "Fruits"
    page_title = find_element(:css, ".page-title")
      |> visible_text

    assert page_title == "Fruits"

    # And I expect Apple in the product displayed
    product = find_element(:css, ".product")

    product_name = find_within_element(product, :css, ".product-name")
      |> visible_text
    product_price = find_within_element(product, :css, ".product-price")
      |> visible_text

    assert product_name == "Apple"
    assert product_price == "₹100"

    # And I expect that Tomato is not present on the screen
    refute page_source() =~ "Tomato"
  end

  test "Show vegetables" do
    ## WHEN ##
    # I navigate to vegetables page
    navigate_to("/categories/vegetables")

    ## THEN ##
    # I expect the page title to be "Vegetables"
    page_title = find_element(:css, ".page-title")
      |> visible_text

    assert page_title == "Vegetables"

    # And I expect Tomato in the product displayed
    product = find_element(:css, ".product")

    product_name = find_within_element(product, :css, ".product-name")
      |> visible_text
    product_price = find_within_element(product, :css, ".product-price")
      |> visible_text

    assert product_name == "Tomato"
    assert product_price == "₹50"

    # And I expect that Apple is not present on the screen
    refute page_source() =~ "Apple"
  end

end
