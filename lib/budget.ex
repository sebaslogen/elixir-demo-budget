defmodule Budget do
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
    # |> filter
    # |> normalize
    # |> sort
    # |> print
  end

  defp parse(string) do
    
  end
end
