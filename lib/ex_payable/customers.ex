defmodule ExPayable.Customers do
  @moduledoc """
  Functions for working with customers at Openpay. Through this API you can:

    * get a customer

  """

  @endpoint "customers"

  @doc """
   Get a customer.
   Gets a customer for given owner using customer ID.
   Returns a `{:ok, customer}` tuple.
   ## Examples
       {:ok, customer} = ExOpenpay.Customers.get(customer_id)
   """
  def get(id) do
    ExPayable.make_request(:get, "#{@endpoint}/#{id}")
  end

end