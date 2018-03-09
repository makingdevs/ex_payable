defmodule ExPayable.Plans do
  @moduledoc """
  Functions for working with plans at Openpay. Through this API you can:

    * create a plan

  You can make plan at the merchant leve

  Openpay API reference: https://www.openpay.mx/docs/api/?shell#planes
  """
  @endpoint "plans"

  @doc """
  Create a plan.

  Create templates for subscriptions. Using plans you can define the amount 
  and frequency of recurrent charges.

  Returns `{:ok, plan}` tuple.

  ## Examples

      params = %{
                  "amount": 150.00,
                  "status_after_retry": "cancelled",
                  "retry_times": 2,
                  "name": "Curso de ingles",
                  "repeat_unit": "month",
                  "trial_days": "30",
                  "repeat_every": "1"
                }

      {:ok, plan} = ExPayable.Plans.create(params)

  """
  def create(params) do
    ExPayable.make_request(:post, @endpoint, params)
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  Get a plan id for default Merchant.
  Returns a `{:ok, plan}` tuple.
  ## Examples
      {:ok, plan} = ExPayable.Plans.get(id)
  """
  def get(id) do
    ExPayable.make_request(:get, "#{@endpoint}/#{id}")
    |> ExPayable.Util.handle_openpay_response
  end

  @doc """
  List all plans for default Merchant.
  ##Example
  ```
  {:ok, plans} = ExPayable.Plans.all
  ```
  """
  def all do
    ExPayable.make_request(:get, @endpoint)
    |> ExPayable.Util.handle_openpay_full_response
  end


end