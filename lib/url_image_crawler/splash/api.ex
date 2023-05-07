defmodule UrlImageCrawler.Splash.Api do

  @callback get(String.t()) :: {:ok, String.t()}
end
