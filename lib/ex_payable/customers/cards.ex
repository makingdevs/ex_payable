defmodule ExPayable.Customers.Cards do
  @moduledoc """
  Functions for working with cards at Openpay. Through this API you can:

    * create a card
    * get a card
    * list cards

  You can make cards at the level of customer

  Openpay API reference: https://www.openpay.mx/docs/api/?shell#tarjetas
  """

  def endpoint_for_cards(customer_id) do
    "customers/#{customer_id}/cards"
  end

  @doc """
  Create a card.

  Creates a card for a customer and params.

  Returns `{:ok, card}` tuple.

  ## Examples

      params = %{
                  card_number: "4242424242424242",
                  holder_name: "Juan Perez Ramirez",
                  expiration_year: "20",
                  expiration_month: "12",
                  cvv2: "123"
                }

      {:ok, card} = ExPayable.Customers.Cards.create(customer_id, params)

  """
  def create(customer_id, params) do
    ExPayable.make_request(:post, endpoint_for_cards(customer_id), params)
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  Get a card for given owner using customer ID.
  Returns a `{:ok, card}` tuple.
  ## Examples
      {:ok, card} = ExPayable.Customers.Cards.get(customer_id, card_id)
  """
  def get(customer_id, card_id) do
    ExPayable.make_request(:get, "#{endpoint_for_cards(customer_id)}/#{card_id}")
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  List all cards given owner using customer ID.
  ##Example
  ```
  {:ok, cards} = ExPayable.Customers.Cards.all(customer_id)
  ```
  """
  def all(customer_id) do
    ExPayable.make_request(:get, endpoint_for_cards(customer_id))
    |> ExPayable.Util.handle_openpay_full_response
  end

end