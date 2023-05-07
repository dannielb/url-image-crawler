defmodule UrlImageCrawler.CLI do
  @moduledoc """
  Top-level module for the CLI application, encapsulating the
  interpretation of command-line arguments. Delegates actual execution to the
  `UrlImageCrawler.Splash` module.

  Most functions in this module should be private, as it should only
  expose the full command-line interface as `main`.

  This module should change if the command-line arguments to the CLI program
  change.
  """
  alias UrlImageCrawler.Splash

  def main([url]) when is_binary(url) do
    with {:ok, {link, images}} <- Splash.fetch(url) do
      response(link, images)
    else
      {:error, :connection_refused} -> IO.puts("Failed to reach Splash server")
    end
  end

  def main(_), do: IO.puts("You must provide a valid URL")

  defp response(links, images) do
    IO.puts("Links:")
    Enum.each(links, &IO.puts(&1))
    IO.puts("--------------------")
    IO.puts("Images:")
    Enum.each(images, &IO.puts(&1))
  end
end
