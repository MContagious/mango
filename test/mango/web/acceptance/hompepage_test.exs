defmodule Mango.Web.HomePageTest do
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

  test "Presense of featured products" do
    ## GIVEN ##
    # There are two products Apple and Tomato price 100 and 50 respectively
    # Where Apple being the only seasonal product

    ## WHEN ##
    # I navigate to homepage
    navigate_to("/")

    ## THEN ##
    # I expect the page title to be "Seasonal products"
    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title == "Seasonal products"

    # And I expect Apple in the product displayed
    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name")   |> visible_text
    product_price = find_within_element(product, :css, ".product-price") |> visible_text

    assert product_name == "Apple"
    assert product_price == "₹100"

    # And I expect that Tomato is not present on screen
    refute page_source() =~ "Tomato"

  end

end
