defmodule Budget do
  alias NimbleCSV.RFC4180, as: CSV
  @moduledoc """
  Documentation for Budget.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Budget.hello
      :world

  """
  def hello(var, dos) do
    IO.puts "#{var}-#{dos}"
  end

  def list_transactions do
    File.read!("transactions-jan.csv")
    |> parse
    |> filter
    # |> normalize
    # |> sort
    # |> print
  end

  defp parse(string) do
    string
    |> String.replace("\r", "")
    |> CSV.parse_string()
  end

  defp filter(rows) do
    Enum.map(rows, &Enum.drop(&1, 1))
  end
end
