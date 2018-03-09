defmodule ExPayable.Charges.Customers do
  @moduledoc """
  Functions for working with charges at Openpay. Through this API you can:

    * create a charge
    * get a charge
    * list charges

  You can make charges at the customer level

  Openpay API reference: https://www.openpay.mx/docs/api/?shell#cargos
  """

  def endpoint_for_charges(customer_id) do
    "customers/#{customer_id}/charges"
  end

  @doc """
  Create a charge.

  Creates a charge for a customer params.

  Returns `{:ok, charge}` tuple.

  ## Examples

      params = %{
        method: "card",
        amount: 100,
        description: "Cargo por membresia",
        order_id: "oid-00051",
        confirm: "false",
        send_email: "false",
        redirect_url: "http://www.openpay.mx/index.html"
      }

      {:ok, charge} = ExPayable.Customers.Charges.create(1000, params)

  """
  def create(customer_id, params) do
    ExPayable.make_request(:post, endpoint_for_charges(customer_id), params)
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  Get a charge for given owner using customer ID.
  Returns a `{:ok, customer}` tuple.
  ## Examples
      {:ok, charge} = ExPayable.Charges.Customers.get(customer_id, charge_id)
  """
  def get(customer_id, charge_id) do
    ExPayable.make_request(:get, "#{endpoint_for_charges(customer_id)}/#{charge_id}")
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  List all charges given owner using customer ID.
  ##Example
  ```
  {:ok, charges} = ExPayable.Charges.Customers.all(customer_id)
  ```
  """
  def all(customer_id) do
    ExPayable.make_request(:get, endpoint_for_charges(customer_id))
    |> ExPayable.Util.handle_openpay_full_response
  end

end