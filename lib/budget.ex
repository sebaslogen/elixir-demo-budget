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
    |> normalize
    |> sort
    |> print
  end

  defp parse(string) do
    string
    |> String.replace("\r", "")
    |> CSV.parse_string()
  end

  defp filter(rows) do
    Enum.map(rows, &Enum.drop(&1, 1))
  end

  defp normalize(rows) do
    Enum.map(rows, &parse_amount(&1))
  end

  defp parse_amount([date, description, amount]) do
    [date, description, parse_to_float(amount)]
  end

  defp parse_to_float(string) do
    string
    |> String.to_float()
    |> abs
  end

  defp sort(rows) do
    Enum.sort(rows, &order_asc_by_amount(&1, &2))
  end

  defp order_asc_by_amount([_, _, first], [_, _, second]) do
    first < second
  end

  defp print(rows) do
    IO.puts "\nTransactions:"
    Enum.each(rows, &print_to_console(&1))
  end

  defp print_to_console([date, description, amount]) do
    IO.puts "#{date} #{description} \t$#{:erlang.float_to_binary(amount, decimals: 2)}"
  end
end
