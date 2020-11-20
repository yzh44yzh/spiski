defmodule SpiskiWeb.PageController do
  use SpiskiWeb, :controller

  def index(conn, params) do
    names = (params["search"]["names"] || "")
            |> String.split(",")
            |> Enum.map(
                 &(
                   &1
                   |> String.trim
                   |> String.split
                   |> (List.first) || ""
                   |> String.trim
                   |> String.capitalize)
               )
            |> Enum.reject(&(&1 == ""))

    data = names |> Enum.map(&(search(&1)))
    Enum.zip(names, data) |> Enum.into(%{}) |> IO.inspect

    render(conn, "index.html", names: names, data: Enum.zip(names, data) |> Enum.into(%{}), db_size: :ets.info(:db)[:size])
  end

  defp search(name) when name != "" do
    raw_data = :ets.match_object(
      :db,
      {:_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, :_, name}
    )
    headers = :ets.lookup(:db, :headers)

    data = Enum.map(
      raw_data,
      fn e ->
        Enum.zip(headers[:headers], Tuple.to_list(e))
        |> Enum.into(%{})
        |> Map.drop(["", "#"])
      end
    )
  end

  defp search(_), do: []
end
