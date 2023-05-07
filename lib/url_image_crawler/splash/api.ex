defmodule UrlImageCrawler.Splash.Api do
  @moduledoc """
  Behavior for Splash API clients.
  """

  @callback get(String.t()) :: {:ok, String.t()}
end
