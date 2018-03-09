defmodule ExPayable.Util do

  def string_map_to_atoms([string_key_map]) do
    string_map_to_atoms string_key_map
  end

  def string_map_to_atoms(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), val}
  end

  def handle_openpay_response(res) do
    cond do
      res["error_code"] -> {:error, res}
      true -> {:ok, ExPayable.Util.string_map_to_atoms res}
    end
  end

  def handle_openpay_full_response(response) do
    cond do
      response[:error] -> {:error, response}
      true -> {:ok, response}
    end
  end

  @doc """
  Takes a keyword list and turns it into proper query values.

  ## Example
  card_data = [
    name: "customer name",
    last_name: "customer last name",
    email: "customer@email.com",
    phone_number: "",
  ]

  ExPayable.URI.encode_query(card) # "{\"phone_number\":\"\",\"name\":\"customer name\",\"last_name\":\"customer last name\",\"email\":\"customer@email.com\"}"
  """
  def encode_query(list) do
    Poison.encode!(Enum.into(list, %{}))
  end

end
