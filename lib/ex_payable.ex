defmodule ExPayable do
  @moduledoc """
  The new payable plugin in elixir
  """
  use HTTPoison.Base

  defmodule MissingSecretKeyError do
    defexception message: """
      The merchant_id setting is required so that we can report the
      correct environment instance to ExPayable. Please configure
      merchant_id in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :ex_openpay, merchant_id: YOUR_MERCHANT_ID
    """
  end

  defmodule MissingApiKeyError do
    defexception message: """
      The api_key setting is required so that we can report the
      correct environment instance to ExPayable. Please configure
      api_key in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :ex_openpay, api_key: YOUR_API_KEY
    """
  end

  defmodule MissingApiBaseUrlError do
    defexception message: """
      The api_base_url setting is required so that we can report the
      correct environment instance to ExPayable. Please configure
      api_base_url in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :ex_openpay, api_base_url: YOUR_API_BASE_URL
    """
  end

  def process_url(endpoint) do
    "https://#{openpay_api_key()}:@#{openpay_api_base_url()}/v1/#{openpay_merchant_id()}/" <> endpoint
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end

  def req_headers() do
    Map.new
      |> Map.put("Content-Type",  "application/json")
  end

  def make_request( method, endpoint, body \\ %{}, headers \\ %{}, options \\ []) do
    rb = ExPayable.Util.encode_query(body)
    requestHeader = req_headers()
        |> Map.merge(headers)
        |> Map.to_list
    {:ok, response} =
      case method do
        _ -> request(method, endpoint, rb, requestHeader, options)
      end
      response.body
  end

  @doc """
  Get the :merchant_id from system env
  if not exist raise a MissingSecretKeyError exception
  """
  def openpay_merchant_id do
    case Application.get_env(:ex_payable, :merchant_id, System.get_env "OPENPAY_MERCHANT_ID") || :not_found do
      :not_found ->
        raise MissingSecretKeyError
      value -> value
    end
  end

  @doc """
  Get the :api_key from system env
  if not exist raise a MissingApiKeyError exception
  """
  def openpay_api_key do 
    case Application.get_env(:ex_payable, :api_key, System.get_env "OPENPAY_API_KEY") || :not_found do
      :not_found ->
        raise MissingApiKeyError
      value -> value
    end
  end

  @doc """
  Get the :api_base_url from system env
  if not exist raise a MissingApiBaseUrlError exception
  """
  def openpay_api_base_url do 
    case Application.get_env(:ex_payable, :api_base_url, System.get_env "OPENPAY_API_BASE_URL") || :not_found do
      :not_found ->
        raise MissingApiBaseUrlError
      value -> value
    end
  end

end
