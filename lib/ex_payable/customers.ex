defmodule ExPayable.Customers do
  @moduledoc """
  Functions for working with customers at Openpay. Through this API you can:

    * get a customer

  """

  @endpoint "customers"

  @doc """
  Create a customer.

  Creates a customer for a customer or customer using params. `params`
  must include a source.

  Returns `{:ok, customer}` tuple.

  ## Examples

      params = [
        name: "customer name",
        last_name: "",
        email: "customer_email@me.com",
        phone_number: "",
        # address: "",
        # external_id: ""
      ]

      {:ok, customer} = ExOpenpay.Customers.create(params)

  """
  def create(params) do
    ExPayable.make_request(:post, @endpoint, params)
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
   Get a customer.
   Gets a customer for given owner using customer ID.
   Returns a `{:ok, customer}` tuple.
   ## Examples
       {:ok, customer} = ExOpenpay.Customers.get(customer_id)
   """
  def get(id) do
    ExPayable.make_request(:get, "#{@endpoint}/#{id}")
    |> ExPayable.Util.handle_openpay_response
  end

end