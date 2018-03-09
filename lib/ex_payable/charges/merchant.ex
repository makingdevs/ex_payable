defmodule ExPayable.Charges.Merchant do
  @moduledoc """
  Functions for working with charges at Openpay. Through this API you can:

    * create a charge

  You can make charges at the level of merchant

  Openpay API reference: https://www.openpay.mx/docs/api/?shell#cargos
  """

  @endpoint "charges"

  @doc """
  Create a charge.

  Creates a charge for a customer params.

  Returns `{:ok, charge}` tuple.

  ## Examples

      params = %{
        method: "card",
        amount: 100,
        description: "Cargo inicial a mi cuenta",
        order_id: "oid-00051",
        customer: %{
             name: "Juan",
             last_name: "Vazquez Juarez",
             phone_number: "4423456723",
             email: "juan.vazquez@empresa.com.mx"
        },
        confirm: "false",
        send_email: "false",
        redirect_url: "http://www.openpay.mx/index.html"
      }

      {:ok, charge} = ExPayable.Charges.create(1000, params)

  """
  def create(params) do
    ExPayable.make_request(:post, @endpoint, params)
    |> ExPayable.Util.handle_openpay_response
  end

  def get(id) do
    ExPayable.make_request(:get, "#{@endpoint}/#{id}")
    |> ExPayable.Util.handle_openpay_response
  end

  def all do
    ExPayable.make_request(:get, @endpoint)
    |> ExPayable.Util.handle_openpay_full_response
  end

end