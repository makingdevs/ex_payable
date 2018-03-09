defmodule ExPayable.Customers.Subscriptions do
  @moduledoc """
  Functions for working with subscription at Openpay. Through this API you can:

    * create a subscription
    * get a subscription
    * list subscriptions

  You can make subscription at the level of customer

  Openpay API reference: https://www.openpay.mx/docs/api/?shell#subcripciones
  """

  def endpoint_for_subscriptions(customer_id) do
    "customers/#{customer_id}/subscriptions"
  end

  @doc """
  Create a subscription.

  Creates a subscription for a customer and params.

  Returns `{:ok, subscription}` tuple.

  ## Examples

      params = %{
                  plan_id:"pbi4kb8hpb64x0uud2eb",
                  # card:{
                    card_number:"4111111111111111",
                    holder_name:"Juan Perez Ramirez",
                    expiration_year:"20",
                    expiration_month:"12",
                    cvv2:"110",
                    device_session_id:"kR1MiQhz2otdIuUlQkbEyitIqVMiI16f"
                  },
                  # source_id: "kq37a02xt0chhxav5o17"
                }

      {:ok, subscription} = ExPayable.Customers.Subscriptions.create(customer_id, params)

  """
  def create(customer_id, params) do
    ExPayable.make_request(:post, endpoint_for_subscriptions(customer_id), params)
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  Get a subscription for given owner using customer ID.
  Returns a `{:ok, subscription}` tuple.
  ## Examples
      {:ok, subscription} = ExPayable.Customers.Subscriptions.get(customer_id, subscription_id)
  """
  def get(customer_id, subscription_id) do
    ExPayable.make_request(:get, "#{endpoint_for_subscriptions(customer_id)}/#{subscription_id}")
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  List all subscriptions given owner using customer ID.
  ##Example
  ```
  {:ok, subscriptions} = ExPayable.Customers.Subscriptions.all(customer_id)
  ```
  """
  def all(customer_id) do
    ExPayable.make_request(:get, endpoint_for_subscriptions(customer_id))
    |> ExPayable.Util.handle_openpay_full_response
  end

end