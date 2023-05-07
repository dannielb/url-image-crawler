defmodule UrlImageCrawler.SplashClient.Api do

  @callback get(String.t()) :: {:ok, String.t()}
end
