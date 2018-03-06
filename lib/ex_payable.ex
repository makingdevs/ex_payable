defmodule ExPayable do
  @moduledoc """
  The new payable plugin in elixir
  """
  use HTTPoison.Base

  defmodule MissingSecretKeyError do
    defexception message: """
      The merchant_id setting is required so that we can report the
      correct environment instance to ExOpenpay. Please configure
      merchant_id in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :ex_openpay, merchant_id: YOUR_MERCHANT_ID
    """
  end

  defmodule MissingApiKeyError do
    defexception message: """
      The api_key setting is required so that we can report the
      correct environment instance to ExOpenpay. Please configure
      api_key in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :ex_openpay, api_key: YOUR_API_KEY
    """
  end

  def process_url(url) do
    "https://sandbox-api.openpay.mx/v1/" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    #|> Map.take(@expected_fields)
    #|> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def req_headers(key) do
    Map.new
      |> Map.put("Content-Type",  "application/json")
      |> Map.put("Accept", "application/json; charset=utf-8")
      |> Map.put("Authorization", "Basic #{key}")
      |> Map.put("User-Agent",    "ExOpenpay/v1 openpay/1.4.0")
  end

  def make_request(method, endpoint, body \\ %{}, headers \\ %{}, options \\ []) do
    make_request_with_key( method, endpoint, openpay_api_key(), body, headers, options )
  end

  def make_request_with_key( method, endpoint, key, body \\ %{}, headers \\ %{}, options \\ []) do
    #rb = ExOpenpay.URI.encode_query(body)
    IO.puts key
    rh = req_headers(key)
        |> Map.merge(headers)
        |> Map.to_list
    IO.inspect rh
    #options = Keyword.merge(httpoison_request_options(), options)
    {:ok, response} =
      case method do
        #:delete -> HTTPoison.delete(process_url(endpoint))
        _ -> request(method, endpoint, "", rh, options)
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

end
