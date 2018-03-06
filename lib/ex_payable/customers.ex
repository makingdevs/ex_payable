defmodule ExPayable.Customers do

  @endpoint "customers"

  def get(id) do
    ExPayable.make_request(:get, "#{@endpoint}/#{id}")
  end

end